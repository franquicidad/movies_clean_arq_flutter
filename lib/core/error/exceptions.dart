class ServerException implements Exception {
  final String serverMessage;

  ServerException({this.serverMessage});
}

class CacheException implements Exception {
  final String cacheMessage;

  CacheException({this.cacheMessage});
}
