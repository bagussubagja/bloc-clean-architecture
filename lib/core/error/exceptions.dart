class ServerException implements Exception {}

class CacheException implements Exception {}

class RouteException implements Exception {
  final String errorMessage;

  RouteException(this.errorMessage);
}