// file: web_socket_error.dart
// date: Jun/20/2022
// brief: WebSocket Error.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


enum WebSocketErrorType {
  subscribeError,
  subscriptionError,
  receivedPostErdError,
  closed,
  disconnected
}

class WebSocketError {
  final WebSocketErrorType type;

  WebSocketError(this.type);
}