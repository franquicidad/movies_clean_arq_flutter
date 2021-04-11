class ServerException implements Exception {
  final String serverMessage;

  ServerException(this.serverMessage);
}

class cacheException implements Exception {
  final String cacheMessage;

  cacheException(this.cacheMessage);
}
