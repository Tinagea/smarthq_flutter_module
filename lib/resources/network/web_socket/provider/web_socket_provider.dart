// file: web_socket_provider.dart
// date: Jun/19/2022
// brief: WebSocket provider
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'dart:async';
import 'dart:convert';
import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_device_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_presence_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_service_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/web_socket_erd_request.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/web_socket_publish_erd_response.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:smarthq_flutter_module/resources/network/web_socket/data_item/web_socket_data_item.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/data_item/web_socket_status_item.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/web_socket_ping_request.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/web_socket_pong_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_account_request.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/web_socket_subscribe_request.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/profile/web_socket_profile.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/web_socket_error.dart';

enum WebSocketStatus {
  disconnected,
  connecting,
  connected,
}

class WebSocketProvider {
  static const tag = "WebSocketProvider:";

  IOWebSocketChannel? _channel;
  late StreamSubscription _subscription;
  StreamController? _broadCast;
  late WebSocketStatus _webSocketStatus;
  WebSocketStatus get webSocketStatus => _webSocketStatus;
  Timer? _pingTimer;

  List<String> _subscriptionList = [
    "/appliance/*/erd/*",
    "/appliance/*/presence",
    "/appliance/*"
  ];
  var _subscriptionCount = 0;
  void _initSubscriptionCount() => _subscriptionCount = _subscriptionList.length;
  void _countSubscription() => _subscriptionCount--;
  bool _isReceivedAllSubscription() => _subscriptionCount == 0;

  static final WebSocketProvider _manager = WebSocketProvider._internal();
  factory WebSocketProvider() => _manager;
  WebSocketProvider._internal() {
    geaLog.debug("${tag}internal");

    _webSocketStatus = WebSocketStatus.disconnected;
  }

  Stream get stream => _broadCast!.stream;
  Stream connect(String endPoint, {bool isReconnect = false}) {
    geaLog.debug("${tag}connect - $endPoint");

    if (_broadCast == null) {
      _broadCast = StreamController.broadcast();
    }
    _channel = _connectWebSocket(endPoint, isReconnect: isReconnect);

    return _broadCast!.stream;
  }

  void close() {
    geaLog.debug("${tag}close");

    _close();
  }

  void postErd(String jid, String erdNumber, String erdValue) {
    geaLog.debug("${tag}postErd");

    final items = jid.split("_");
    final applianceId = items.first;
    final userId = items.last;
    final erdNumberValue = erdNumber.toUpperCase().replaceFirst("0X", "0x");
    final method = "POST";

    final jsonData = WebSocketErdRequest(
        kind: WebSocketProfile.webSocketKindApi,
        action: "api",
        host: BuildEnvironment.config.apiHost.replaceAll("https://", ""),
        method: method,
        path: "/v1/appliance/${applianceId.toUpperCase()}/erd/$erdNumberValue",
        id: "$method-${applianceId.toLowerCase()}_${userId.toLowerCase()}-$erdNumberValue-$erdValue",
        body: Body(
            kind: "appliance#erdListEntry",
            applianceId: applianceId.toUpperCase(),
            userId: userId.toLowerCase(),
            erd: erdNumberValue,
            value: erdValue,
            ackTimeout: 10,
            delay: 0
        )).toJson();

    final sendData = json.encode(jsonData);
    if (_channel != null) {
      _channel!.sink.add(sendData);
    }
  }

  void requestCache(String jid) {
    geaLog.debug("${tag}requestCache");

    final items = jid.split("_");
    final applianceId = items.first;
    final method = "GET";

    final jsonData = WebSocketErdRequest(
        kind: WebSocketProfile.webSocketKindApi,
        action: "api",
        host: BuildEnvironment.config.apiHost.replaceAll("https://", ""),
        method: method,
        path: "/v1/appliance/${applianceId.toUpperCase()}/erd",
        id: "CACHE-${applianceId.toUpperCase()}").toJson();

    final sendData = json.encode(jsonData);
    if (_channel != null) {
      _channel!.sink.add(sendData);
    }
  }

  @Deprecated('Use requestCache instead.')
  void requestErd(String jid, String erdNumber) {
    geaLog.debug("${tag}requestErd");

    final items = jid.split("_");
    final applianceId = items.first;
    final method = "GET";
    final erdNumberValue = erdNumber.toUpperCase().replaceFirst("0X", "0x");

    final jsonData = WebSocketErdRequest(
        kind: WebSocketProfile.webSocketKindApi,
        action: "api",
        host: BuildEnvironment.config.apiHost.replaceAll("https://", ""),
        method: method,
        path: "/v1/appliance/${applianceId.toUpperCase()}/erd/$erdNumberValue",
        id: "ONEERD-${applianceId.toUpperCase()}").toJson();

    final sendData = json.encode(jsonData);
    if (_channel != null) {
      _channel!.sink.add(sendData);
    }
  }

  void _close() {
    geaLog.debug("${tag}_close");

    final channel = _channel;
    if (channel != null) {
      channel.sink.close(status.goingAway);
      _webSocketStatus = WebSocketStatus.disconnected;
      _subscription.cancel();
      _channel = null;
    }

    if (_broadCast != null) {
      _broadCast?.close();
      _broadCast = null;
    }

    _stopPingTimer();
  }

  IOWebSocketChannel _connectWebSocket(String endPoint, {bool isReconnect = false}) {
    geaLog.debug("${tag}_connectWebSocket");

    _webSocketStatus = WebSocketStatus.connecting;
    final channel = IOWebSocketChannel.connect(endPoint);
    _subscription = channel.stream.listen(null);

    _listenSubscription(_subscription, channel.sink, _broadCast!, isReconnect: isReconnect);
    _onErrorSubscription(_subscription, _broadCast!);

    return channel;
  }

  void _onErrorSubscription(StreamSubscription subscription, StreamController broadCast) {

    subscription.onError((error) {
      /// It is occurred when the user sign out the app.
      geaLog.error("${tag}WebSocket has an Error:$error. Try to reconnect.");

      broadCast.addError(WebSocketError(WebSocketErrorType.disconnected));
      _close();
    });

    subscription.onDone(() {
      /// It is occurred when the app uses the endpoint that be created by the same MDT.
      /// It is occurred when the access token is expired.
      /// It is occurred when the ping is not send within one minute.
      geaLog.debug("${tag}WebSocket has a Done.");

      broadCast.addError(WebSocketError(WebSocketErrorType.closed));
      _close();
    });
  }

  void _listenSubscription(StreamSubscription subscription, WebSocketSink sink,
      StreamController broadCast, {bool isReconnect = false}) {

    subscription.onData((message) {
      geaLog.debug("${tag}onOriginData:$message");
      final receivedMessage = json.decode(message);
      geaLog.debug("${tag}onDecodeData:$receivedMessage");

      final kind = receivedMessage["kind"];
      switch (kind) {
        case WebSocketProfile.webSocketKindConnect:
          _handleKindConnect(receivedMessage, sink, broadCast);
          break;
        case WebSocketProfile.webSocketKindSubscribe:
          _handleKindSubscribe(receivedMessage, sink, broadCast);
          break;
        case WebSocketProfile.webSocketKindSubscription:
          _handleKindSubscription(
              receivedMessage, sink, broadCast, isReconnect: isReconnect);
          break;
        case WebSocketProfile.webSocketKindApi:
          _handleKindApi(receivedMessage, broadCast);
          break;
        case WebSocketProfile.webSocketKindPong:
          _handlePong(receivedMessage, broadCast);
          break;
        case WebSocketProfile.webSocketPublishPresence:
          _handlePublishPresence(receivedMessage, broadCast);
          break;
        case WebSocketProfile.webSocketPublishErd:
          _handlePublishErd(receivedMessage, broadCast);
          break;
        case WebSocketProfile.webSocketPublishProvision:
          _handlePublishProvision(receivedMessage, broadCast);
          break;
        case WebSocketProfile.webSocketPubSub:
          _handlePubSub(receivedMessage, broadCast);
          break;
        case WebSocketProfile.webSocketPubSubDevice:
          _handlePubSubDevice(receivedMessage, broadCast);
          break;
        case WebSocketProfile.webSocketPubSubService:
          _handlePubSubService(receivedMessage, broadCast);
          break;
        case WebSocketProfile.webSocketPubSubPresence:
          _handlePubSubPresence(receivedMessage, broadCast);
          break;
        case WebSocketProfile.webSocketPubSubCommand:
          _handlePubSubCommand(receivedMessage, broadCast);
          break;
        default:
          geaLog.warning("The kind value($kind) is not handled by the app");
          break;
      }
    });
  }

  void _handleKindConnect(Map<String, dynamic> receivedMessage, WebSocketSink sink, StreamController broadCast) {
    geaLog.debug("${tag}_handleKindConnect");

    bool isSuccess = receivedMessage["success"];
    if (isSuccess) {
      _webSocketStatus = WebSocketStatus.connected;
      _addSubscribe(sink);
      _startPingTimer(sink);
      broadCast.add(
          WebSocketStateItem(
              type: WebSocketStateType.webSocketConnected));
    }
    else {
      // this case is impossible, hopefully. failed connection
      // Connection Error
    }
  }

  void _addSubscribe(WebSocketSink sink) {
    geaLog.debug("${tag}_addSubscribe");

    final jsonData = WebSocketSubscribeRequest(
        kind: WebSocketProfile.webSocketKindSubscribe,
        action: "subscribe",
        resources: _subscriptionList
    ).toJson();

    final sendData = json.encode(jsonData);
    sink.add(sendData);
  }

  void _handleKindSubscribe(Map<String, dynamic> receivedMessage, WebSocketSink sink, StreamController broadCast) {
    geaLog.debug("${tag}_handleKindSubscribe");

    bool isSuccess = receivedMessage["success"];
    if (isSuccess) {
      _initSubscriptionCount();
    }
    else {
      broadCast.addError(WebSocketError(WebSocketErrorType.subscribeError));
    }
  }

  void _handleKindSubscription(Map<String, dynamic> receivedMessage, WebSocketSink sink, StreamController broadCast, {bool isReconnect = false}) {
    bool isSuccess = receivedMessage["success"];
    if (isSuccess) {
      _countSubscription();
      if (_isReceivedAllSubscription()) {
        if (isReconnect) {
          broadCast.add(
              WebSocketStateItem(
                  type: WebSocketStateType.webSocketRefreshed));
        } else {
          broadCast.add(
              WebSocketStateItem(
                  type: WebSocketStateType.webSocketReadyToService));
        }
        _addPubSub(sink);
      }
    }
    else {
      broadCast.addError(WebSocketError(WebSocketErrorType.subscriptionError));
    }
  }

  void _addPubSub(WebSocketSink sink) {
    geaLog.debug("${tag}_addPubSub");

    final jsonData = WebSocketPubSubAccountRequest(
        kind: WebSocketProfile.webSocketPubSub,
        action: "pubsub",
        pubsub: true,
        alerts: true,
        services: true,
        presence: true,
    ).toJson();

    final sendData = json.encode(jsonData);
    sink.add(sendData);
  }

  void _handleKindApi(Map<String, dynamic> receivedMessage, StreamController broadCast) {
    final String id = receivedMessage["id"];
    final body = receivedMessage["body"];
    final bool isSuccess = receivedMessage["success"];
    final int code = receivedMessage["code"];

    if (id.startsWith("CACHE") || id.startsWith("ONEERD") || id.startsWith("POST")) {
      if (isSuccess && code == 200) {
        if (id.startsWith("CACHE")) {
          final userId = body["userId"];
          final applianceId = body["applianceId"];
          final jid = "${applianceId.toLowerCase()}_$userId";

          final List items = body["items"];
          final cache = items.map((item) {
            return WebSocketErdData(
                erd: item["erd"]?.toLowerCase(),
                value: item["value"]?.toLowerCase(),
                timestamp: item["time"]
                );
          }).toList();
          broadCast.add(WebSocketStateItem(
              type: WebSocketStateType.webSocketReceivedCache,
              dataItem: WebSocketDataCacheItem(
                  jid: jid,
                  cache: cache)
          ));
        } else if (id.startsWith("ONEERD")) {
          final userId = body["userId"];
          final applianceId = body["applianceId"];
          final jid = "${applianceId.toLowerCase()}_$userId";
          final String erd = body["erd"];
          final String value = body["value"];
          broadCast.add(WebSocketStateItem(
              type: WebSocketStateType.webSocketReceivedErd,
              dataItem: WebSocketDataErdItem(
                  jid: jid,
                  erd: erd.toLowerCase(),
                  value: value.toLowerCase())
          ));
        } else if (id.startsWith("POST")) {
          final data = id.split("-");
          final String jid = data.elementAt(1);
          final String erd = data.elementAt(2);
          final String value = data.elementAt(3);
          final status = body["status"];
          broadCast.add(WebSocketStateItem(
              type: WebSocketStateType.webSocketReceivedPostErdSuccess,
              dataItem: WebSocketDataPostErdItem(
                  jid: jid,
                  erd: erd.toLowerCase(),
                  value: value.toLowerCase(),
                  status: status)
          ));
        }
      } else {
        geaLog.warning("ERD or POST or CACHE are not handled by the app since it is failed.");
        geaLog.warning("code: $code");
      }
    } else {
      final isSuccess = receivedMessage["success"];
      if (isSuccess) {
        final kind = receivedMessage["body"]["kind"];
        geaLog.warning("The Kind($kind) is not handled by the app");
      }
      else {
        final request = receivedMessage["request"].toString();
        final reason = receivedMessage["reason"];
        geaLog.warning("The api id($id) is not handled by the app since it is failed");
        geaLog.warning("request: $request\n"
                       "reason: $reason\n");
      }
    }
  }

  void _handlePong(Map<String, dynamic> receivedMessage, StreamController broadCast) {
    final response = WebSocketPongResponse.fromJson(receivedMessage);
    broadCast.add(WebSocketStateItem(
        type: WebSocketStateType.webSocketReceivedPong,
        dataItem: WebSocketDataPongItem(
            id: response.id)
    ));
  }

  void _handlePublishPresence(Map<String, dynamic> receivedMessage, StreamController broadCast) {
    final userId = receivedMessage["userId"];
    final applianceId = receivedMessage["item"]["applianceId"];
    final jid = "${applianceId.toLowerCase()}_$userId";
    final String presence = receivedMessage["item"]["status"];
    broadCast.add(WebSocketStateItem(
        type: WebSocketStateType.webSocketAppliancePresence,
        dataItem: WebSocketDataPresenceItem(
            jid: jid.toLowerCase(),
            presence: presence.toLowerCase())
    ));
  }

  void _handlePublishErd(Map<String, dynamic> receivedMessage, StreamController broadCast) {

    final response = WebSocketPublishErdResponse.fromJson(receivedMessage);

    final userId = response.userId;
    final applianceId = response.item?.applianceId ?? "";
    final jid = "${applianceId.toLowerCase()}_$userId";
    final erdNumber = response.item?.erd ?? "";
    final erdValue = response.item?.value ?? "";
    final timeStamp = response.item?.time ?? "";
    broadCast.add(WebSocketStateItem(
        type: WebSocketStateType.webSocketReceivedPublishErd,
        dataItem: WebSocketDataPublishErdItem(
            jid:jid.toLowerCase(),
            erdNumber: erdNumber.toLowerCase(),
            erdValue: erdValue.toLowerCase(),
            timeStamp: timeStamp)
    ));
  }

  void _handlePublishProvision(Map<String, dynamic> receivedMessage, StreamController broadCast) {
    final userId = receivedMessage["userId"];
    final applianceId = receivedMessage["item"]["applianceId"];
    final jid = "${applianceId.toLowerCase()}_$userId";
    final String status = receivedMessage["item"]["status"];
    broadCast.add(WebSocketStateItem(
        type: WebSocketStateType.webSocketApplianceProvision,
        dataItem: WebSocketDataProvisionItem(
            jid:jid.toLowerCase(),
            status: status.toLowerCase())
    ));
  }

  void _handlePubSub(Map<String, dynamic> receivedMessage, StreamController broadCast) {
    /// PayLoad
    /// success : bool
    /// kind : String
    final success = receivedMessage['success'];
    final result = success ? "Success" : "Failure";
    geaLog.debug("${tag}_handlePubSub-$result");
  }

  void _handlePubSubDevice(Map<String, dynamic> receivedMessage, StreamController broadCast) {
    geaLog.debug("${tag}_handlePubSubDevice");

    final response = WebSocketPubSubDeviceResponse.fromJson(receivedMessage);
    broadCast.add(WebSocketStateItem(
        type: WebSocketStateType.webSocketReceivedPubSubDevice,
        dataItem: WebSocketDataPubSubItem(device: response)
    ));
  }

  void _handlePubSubService(Map<String, dynamic> receivedMessage, StreamController broadCast) {
    geaLog.debug("${tag}_handlePubSubService");

    final response = WebSocketPubSubServiceResponse.fromJson(receivedMessage);
    broadCast.add(WebSocketStateItem(
        type: WebSocketStateType.webSocketReceivedPubSubService,
        dataItem: WebSocketDataPubSubItem(service: response)
    ));
  }

  void _handlePubSubPresence(Map<String, dynamic> receivedMessage, StreamController broadCast) {
    geaLog.debug("${tag}_handlePubSubPresence");

    final response = WebSocketPubSubPresenceResponse.fromJson(receivedMessage);
    broadCast.add(WebSocketStateItem(
        type: WebSocketStateType.webSocketReceivedPubSubPresence,
        dataItem: WebSocketDataPubSubItem(presence: response)
    ));
  }

  void _handlePubSubCommand(Map<String, dynamic> receivedMessage, StreamController broadCast) {
    geaLog.debug("${tag}_handlePubSubCommand");
    // TODO: It should be implemented
  }

  void _startPingTimer(WebSocketSink sink) {
    geaLog.debug("${tag}_startPingTimer");
    if (_pingTimer == null) {
      _pingTimer = Timer.periodic(Duration(seconds: 55), (timer) {
        _sendPing(sink);
      });
    }
  }

  void _sendPing(WebSocketSink sink) {
    geaLog.debug("${tag}_sendPing");
    if (_webSocketStatus == WebSocketStatus.connected) {
      final jsonData = WebSocketPingRequest(
        kind: WebSocketProfile.webSocketKindPing,
        action: "ping",
        id: "0416",
      ).toJson();

      final sendData = json.encode(jsonData);
      sink.add(sendData);
    }
  }

  void _stopPingTimer() {
    geaLog.debug("${tag}_stopPingTimer");
    if (_pingTimer != null) {
      _pingTimer?.cancel();
      _pingTimer = null;
    }
  }
}