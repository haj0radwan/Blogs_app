class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class CachException implements Exception {
  final String message;
  const CachException(this.message);
}
