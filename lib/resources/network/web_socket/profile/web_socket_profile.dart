// file: web_socket_profile.dart
// date: Jun/20/2022
// brief: WebSocket profile value.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


abstract class WebSocketProfile {
  static const webSocketKindConnect           = "websocket#connect";
  static const webSocketKindSubscribe         = "websocket#subscribe";
  static const webSocketKindSubscription      = "websocket#subscription";
  static const webSocketKindApi               = "websocket#api";
  static const webSocketKindPing              = "websocket#ping";
  static const webSocketKindPong              = "websocket#pong";
  static const webSocketPubSub                = "websocket#pubsub";

  static const webSocketPublishPresence       = "publish#presence";
  static const webSocketPublishErd            = "publish#erd";
  static const webSocketPublishProvision      = "publish#provision";

  static const presenceAvailable              = "online";
  static const presenceUnavailable            = "offline";

  static const webSocketPubSubDevice          = "pubsub#device";
  static const webSocketPubSubPresence        = "pubsub#presence";
  static const webSocketPubSubService         = "pubsub#service";
  static const webSocketPubSubCommand         = "pubsub#command";


}