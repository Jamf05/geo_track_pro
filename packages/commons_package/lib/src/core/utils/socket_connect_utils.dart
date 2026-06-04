import 'dart:io';

final class SocketConnectUtils {
  static List<Future<bool>> createSocketFutures(
    List<String> ips,
    List<String> ports,
    int timeoutMilliseconds,
  ) {
    final List<Future<bool>> socketFutures = [];
    for (int i = 0; i < ips.length; i++) {
      socketFutures.add(
        Socket.connect(
          ips[i],
          int.parse(ports[i]),
          timeout: Duration(milliseconds: timeoutMilliseconds),
        ).then((socket) {
          socket.destroy();
          return true;
        }).catchError((_) => false),
      );
    }
    return socketFutures;
  }
}
