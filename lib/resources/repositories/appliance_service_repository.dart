// file: appliance_service_repository.dart
// date: Jun/20/2022
// brief: A class for appliance service repository.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'dart:async';

import 'package:smarthq_flutter_module/managers/shared_data_manager.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/provider/rest_api_account_provider.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/provider/rest_api_api_provider.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/data_item/web_socket_data_item.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_device_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_presence_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_service_response.dart';
import 'package:smarthq_flutter_module/resources/repositories/action/appliance_service_action.dart';
import 'package:smarthq_flutter_module/resources/storage/erd_storage.dart';
import 'package:smarthq_flutter_module/resources/storage/native_storage.dart';
import 'package:smarthq_flutter_module/services/life_cycle_service.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/data_item/web_socket_status_item.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/provider/web_socket_provider.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/web_socket_error.dart';

abstract class ApplianceServiceRepository {
  /// add the observer to listen the information
  void addObserver(ApplianceServiceObserver observer);
  /// remove the observer
  void removeObserver(ApplianceServiceObserver observer);

  /// add the observer to listen the information for Data Model
  void addDataModelObserver(ApplianceServiceDataModelObserver observer);
  /// remove the observer for Data Model
  void removeDataModelObserver(ApplianceServiceDataModelObserver observer);


  /// return the status of the appliance service repository.
  ApplianceServiceStatus getStatus();

  /// start the appliance service repository.
  /// When Status is "inService", it is possible to use.
  /// "Status" can be checked through getStatus() or onChangeStatus().
  Future<bool> startService();

  /// stop the appliance service repository.
  void stopService();

  /// request to the server to edit the erd value.
  /// Response: onReceivedPostErdResult()
  void postErd(String jid, String erdNumber, String erdValue);

  /// request to the server to get the all erd values.
  /// Response: onReceivedCache()
  void requestCache(String jid);

  /// return the erd value from memory.
  String? getErdValue(String jid, String erdNumber);

  /// return the all erd values from memory.
  List<Map<String, String>?>? getCache(String jid);
  Map<String, String> formatCache(List<Map<String, String>?>? cache);
}

abstract class ApplianceServiceObserver {
  void onReceivedCache(String jid, List<Map<String, String>> cache, List<Map<String, String>> timeStamps);
  void onReceivedPostErdResult(String jid, String erdNumber, String erdValue, String status);
  void onChangeStatus(ApplianceServiceStatus status);
  void onReceivedErd(String jid, String erdNumber, String erdValue, String timeStamp);
}

abstract class ApplianceServiceDataModelObserver {
  void pubSubDevice(WebSocketPubSubDeviceResponse response);
  void pubSubService(WebSocketPubSubServiceResponse response);
  void pubSubPresence(WebSocketPubSubPresenceResponse response);
  void pubSubCommand();
}

enum ApplianceServiceStatus {
  /// Status that could not use the ApplianceService
  closed,

  /// Status that is Servicing...
  inService,

  /// Status that start to refresh the connection.
  /// ApplianceService must be closed and reconnected since the access token is valid during 1hour.
  /// Requests(Actions) that occur during refreshing are stored in the action queue.
  refreshing,

  /// Finish the refreshing the connection.
  /// Requests(Actions) that have been stored in the action queue are delivered to the server immediately after reconnection.
  /// Please note below.
  /// The ApplianceService will not receive messages from the server during the time it tries to reconnect.
  /// So, it is recommended to synchronize with the server when refreshed,
  refreshed,

  /// The Service is paused according to App's Life Cycle.
  paused,

  /// The Service is resumed according to App's Life Cycle.
  resumed
}

class ApplianceServiceRepositoryImpl implements ApplianceServiceRepository, LifeCycleObserver {
  static const String tag = "ApplianceServiceRepositoryImpl";

  final List<ApplianceServiceAction> _actionQueue = [];
  final List<ApplianceServiceObserver> _observers = [];
  final List<ApplianceServiceDataModelObserver> _dataModelObservers = [];
  Stream? _stream;
  StreamSubscription? _subscription;

  final _webSocket = WebSocketProvider();
  final _restApiApi = RestApiApiProvider();
  final _restApiAccount = RestApiAccountProvider();
  // ignore: unused_field
  late ChannelManager _channelManager;
  late ErdStorage _erdStorage;
  late SharedDataManager _sharedDataManager;
  late NativeStorage _nativeStorage;

  late ApplianceServiceStatus _status;

  // TODO: this code is add by interapt. so it must be removed.
  String? hasRequestedButFailedJID;

 ApplianceServiceRepositoryImpl({
    required ChannelManager channelManager,
    required ErdStorage erdStorage,
    required SharedDataManager sharedDataManager,
    required NativeStorage nativeStorage,
  }) {
    _channelManager = channelManager;
    _erdStorage = erdStorage;
    _sharedDataManager = sharedDataManager;
    _nativeStorage = nativeStorage;
    _updateStatus(ApplianceServiceStatus.closed);
  }

  @override
  ApplianceServiceStatus getStatus() {
    geaLog.debug('$tag::getStatus($_status)');
    return _status;
  }

  @override
  void addObserver(ApplianceServiceObserver observer) {
    geaLog.debug('$tag::addObserver()');
    _observers.add(observer);
  }

  @override
  void removeObserver(ApplianceServiceObserver observer) {
    geaLog.debug('$tag::removeObserver()');
    _observers.remove(observer);
  }

  @override
  void addDataModelObserver(ApplianceServiceDataModelObserver observer) {
    geaLog.debug('$tag::addDataModelObserver()');
    _dataModelObservers.add(observer);
  }

  @override
  void removeDataModelObserver(ApplianceServiceDataModelObserver observer) {
    geaLog.debug('$tag::removeDataModelObserver()');
    _dataModelObservers.remove(observer);
  }

  @override
  Future<bool> startService() async {
    geaLog.debug('$tag::startService()');
    var isSuccess = false;

    if (_status == ApplianceServiceStatus.closed) {
      isSuccess = await _connectWebSocket();
    }

    return isSuccess;
  }

  Future<bool> _connectWebSocket({bool isReconnect = false}) async {
    var isSuccess = false;
    if (await _refreshGeToken()) {
      final endPointResponse = await _restApiApi.getEndPoint();
      final endPoint = endPointResponse.endpoint;
      final userID = endPointResponse.userId;
      if (endPoint != null) {
        _stream = _webSocket.connect(endPoint, isReconnect: isReconnect);
        _nativeStorage.setUserId = userID;
        _subscription = _stream?.listen(null);
        if (_subscription != null) {
          _listenWebSocketState(_subscription!);
          _onErrorWebSocket(_subscription!);
          isSuccess = true;
        }
      }
    }
    return isSuccess;
  }

  Future<bool> _refreshGeToken() async {
    var isSuccess = false;

    /// try to refresh the getoken For 10 seconds
    var tryCount = 10, tryAgain = true;
    while (tryAgain && tryCount > 0) {
      try {
        final response = await _restApiAccount.requestGeToken();
        final geToken = response.accessToken;
        if (geToken != null) {
          geaLog.debug('$tag::_refreshGeToken() - Success to get new geToken: $geToken');
          await _sharedDataManager.setStringValue(SharedDataKey.geToken, geToken);
          isSuccess = true;
          tryAgain = false;
        }
      } catch (error) {
        tryAgain = true;
        tryCount -= 1;
        await Future.delayed(Duration(seconds: 1));
      }
    }

    return isSuccess;
  }

  @override
  void stopService() {
    geaLog.debug('$tag::stopService()');
    if (_status == ApplianceServiceStatus.inService) {
      _closeWebSocket();
      _updateStatus(ApplianceServiceStatus.closed);
      _actionQueue.clear();
    }
  }

  void _closeWebSocket() {
    geaLog.debug('$tag::_closeWebSocket()');
    _subscription?.cancel();
    _subscription = null;
    _stream = null;

    _webSocket.close();
  }

  @override
  void postErd(String jid, String erdNumber, String erdValue) {
    geaLog.debug('$tag::postErd(jid:$jid, erdNumber:$erdNumber, erdValue:$erdValue)');
    if (_status == ApplianceServiceStatus.inService) {
      _webSocket.postErd(jid, erdNumber, erdValue);
    }
    else if (_status == ApplianceServiceStatus.refreshing) {
      _actionQueue.add(ApplianceServicePostErdAction(jid, erdNumber, erdValue));
    }
  }

  @override
  void requestCache(String jid) {
    geaLog.debug('$tag::requestCache(jid:$jid)');
    if (_status == ApplianceServiceStatus.inService) {
      _webSocket.requestCache(jid);
    }
    else if (_status == ApplianceServiceStatus.refreshing) {
      _actionQueue.add(ApplianceServiceCacheAction(jid));
    }
    else {
      hasRequestedButFailedJID = jid;
    }
  }

  @override
  List<Map<String, String>?>? getCache(String jid) {
    geaLog.debug('$tag::getCache(jid:$jid)');
    return _erdStorage.getCache(jid);
  }

  @override
  String? getErdValue(String jid, String erdNumber) {
    geaLog.debug('$tag::getErdValue(jid:$jid, erdNumber:$erdNumber)');
    return _erdStorage.getErdValue(jid, erdNumber);
  }

  void _listenWebSocketState(StreamSubscription subscription) {
    subscription.onData((item) async {
      geaLog.debug('$tag:onData:$item');

      if (item is WebSocketStateItem) {
        var dataItem = item.dataItem;

        switch (item.type) {
          case WebSocketStateType.webSocketConnected:
            break;

          case WebSocketStateType.webSocketRefreshed:
            await _shrinkAction();
            _updateStatus(ApplianceServiceStatus.refreshed);
            _updateStatus(ApplianceServiceStatus.inService);
            break;

          case WebSocketStateType.webSocketReadyToService:
            geaLog.debug('successfully connected');
            _updateStatus(ApplianceServiceStatus.inService);

            if (hasRequestedButFailedJID != null) {
              requestCache(hasRequestedButFailedJID!);
              hasRequestedButFailedJID = null;
            }
            break;

          case WebSocketStateType.webSocketReceivedPostErdSuccess:
            if (dataItem is WebSocketDataPostErdItem) {

              _erdStorage.setErdValue(
                  dataItem.jid!,
                  dataItem.erd!,
                  dataItem.value!);

              _observers.forEach((observer) {
                observer.onReceivedPostErdResult(
                    dataItem.jid!,
                    dataItem.erd!,
                    dataItem.value!,
                    dataItem.status!);
              });
            }
            break;

          case WebSocketStateType.webSocketReceivedCache:
            if (dataItem is WebSocketDataCacheItem) {
              final cache = dataItem.cache?.map((item) {
                return {item.erd!:item.value!};
              }).toList();

              final timestamps = dataItem.cache?.map((item) {
                return {item.erd!:item.timestamp!};
              }).toList();

              _erdStorage.setCache(dataItem.jid!, cache!);

              _observers.forEach((observer) {
                observer.onReceivedCache(dataItem.jid!, cache, timestamps!);
              });
            }
            break;

          case WebSocketStateType.webSocketReceivedPublishErd:
            if (dataItem is WebSocketDataPublishErdItem) {
              _observers.forEach((observer) {
                
                observer.onReceivedErd(dataItem.jid!, dataItem.erdNumber!, dataItem.erdValue!, dataItem.timeStamp!);
              });
            }
            break;

          case WebSocketStateType.webSocketReceivedPubSubDevice:
            if (dataItem is WebSocketDataPubSubItem) {
              _dataModelObservers.forEach((observer) {
                observer.pubSubDevice(dataItem.device!);
              });
            }
            break;

          case WebSocketStateType.webSocketReceivedPubSubService:
            if (dataItem is WebSocketDataPubSubItem) {
              _dataModelObservers.forEach((observer) {
                observer.pubSubService(dataItem.service!);
              });
            }
            break;

          case WebSocketStateType.webSocketReceivedPubSubPresence:
            if (dataItem is WebSocketDataPubSubItem) {
              _dataModelObservers.forEach((observer) {
                observer.pubSubPresence(dataItem.presence!);
              });
            }
            break;

          default:
            geaLog.debug("Do not handle item type(${item.type})");
            break;
        }
      }
    });
  }

  void _onErrorWebSocket(StreamSubscription subscription) {
    subscription.onError((error) async {
      geaLog.debug('$tag:onError:$error');
      final webSocketError = error as WebSocketError;
      switch (webSocketError.type) {
        case WebSocketErrorType.closed:
          _refreshService();
          break;
        case WebSocketErrorType.disconnected:
          _updateStatus(ApplianceServiceStatus.closed);
          break;
        default:
          break;
      }
    });
  }

  void _updateStatus(ApplianceServiceStatus status) {
    geaLog.debug('$tag::_updateStatus($status)');
    _status = status;
    _observers.forEach((observer) {
      observer.onChangeStatus(status);
    });
  }

  Future _refreshService() async {
    geaLog.debug('$tag::_refreshService()');
    _updateStatus(ApplianceServiceStatus.refreshing);
    final reconnected = await _reconnectWebSocket();
    if (!reconnected) {
      _updateStatus(ApplianceServiceStatus.closed);
    }
    return reconnected;
  }

  Future<bool> _reconnectWebSocket() async {
    geaLog.debug('$tag::_reconnectWebSocket()');
    var isSuccess = false;
    _closeWebSocket();
    isSuccess = await _connectWebSocket(isReconnect: true);
    return isSuccess;
  }

  Future _shrinkAction() async {
    geaLog.debug('$tag::_shrinkAction(totalCount-${_actionQueue.length})');
    _actionQueue.forEach((action) async {
      if (action is ApplianceServiceCacheAction) {
        _webSocket.requestCache(action.jid);
      } else if (action is ApplianceServicePostErdAction) {
        _webSocket.postErd(action.jid, action.erdNumber, action.erdValue);
      }
      await Future.delayed(Duration(milliseconds: 200));
    });

    _actionQueue.clear();
  }

  Map<String, String> formatCache(List<Map<String, String>?>? cache){
    Map<String, String> cacheMap = {};
    if(cache == null) {
      return cacheMap;
    }

    for (int i = 0; i < cache.length; i++){
      Map<String, String>? entry = cache[i];
      cacheMap[entry?.keys.first ?? ""] = entry?.values.first ?? "";
    }

    return cacheMap;
  }
  /// LifeCycleObserver
  Timer? _pauseTimer;
  @override
  void onChangeStatus(LifeCycleStatus status) {
    geaLog.debug('$tag::onChangeStatus($status)');
    switch (status) {
      case LifeCycleStatus.paused:
        if (_pauseTimer == null) {
          _pauseTimer = Timer(Duration(seconds: 10), () {
            _pauseService();
            _pauseTimer?.cancel();
            _pauseTimer = null;
          });
        }
        break;
      case LifeCycleStatus.resumed:
        if (_pauseTimer != null) {
          _pauseTimer?.cancel();
          _pauseTimer = null;
          _updateStatus(ApplianceServiceStatus.resumed);
          _updateStatus(ApplianceServiceStatus.inService);
        } else {
          _resumeService();
        }
        break;

      default:
        break;
    }
  }

  void _pauseService() {
    geaLog.debug('$tag::_pauseService');
    _updateStatus(ApplianceServiceStatus.paused);
    _closeWebSocket();
    _actionQueue.clear();
  }

  void _resumeService() async {
    geaLog.debug('$tag::_resumeService');
    _updateStatus(ApplianceServiceStatus.resumed);
    await _connectWebSocket(isReconnect: true);
  }
}
