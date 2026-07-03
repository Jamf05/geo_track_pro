import 'dart:io';

final class SocketConnectUtils {
  static Future<List<bool>> createSocketFutures(
    List<String> ips,
    List<String> ports,
    int timeoutMilliseconds,
  ) async {
    final List<Future<bool>> socketFutures = <Future<bool>>[];
    for (int index = 0; index < ips.length; index++) {
      socketFutures.add(
        _connectSocket(ips[index], ports[index], timeoutMilliseconds),
      );
    }

    return Future.wait(socketFutures);
  }

  static Future<bool> _connectSocket(
    String ip,
    String port,
    int timeoutMilliseconds,
  ) async {
    try {
      final socket = await Socket.connect(
        ip,
        int.parse(port),
        timeout: Duration(milliseconds: timeoutMilliseconds),
      );
      socket.destroy();

      return true;
    } catch (_) {
      return false;
    }
  }
}
