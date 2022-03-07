class ServerException implements Exception {}

class CacheException implements Exception {}

class UnauthorizeException implements Exception {}

class ResponseException implements Exception {
  final int? errorCode;
  final String? message;

  ResponseException({required this.errorCode, required this.message});
}

class MetaException implements Exception {
  final int? errorCode;
  final String? message;

  MetaException({required this.errorCode, required this.message});
}
