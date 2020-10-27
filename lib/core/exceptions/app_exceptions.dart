class ConnectionExceptions implements Exception {}

class TimeoutException extends ConnectionExceptions {
  TimeoutException() : super();
}

class NetworkException extends ConnectionExceptions {
  NetworkException() : super();
}

class BadRequestException extends ConnectionExceptions {
  BadRequestException() : super();
}

class UnauthorisedException extends ConnectionExceptions {
  UnauthorisedException() : super();
}

class ServerException extends ConnectionExceptions {
  ServerException() : super();
}

class CacheException implements Exception {
  final String message;

  CacheException({this.message});
}

class CacheLoadException extends CacheException {
  CacheLoadException({String message}) : super(message: message);
}

class CacheSaveException extends CacheException {
  CacheSaveException() : super();
}

class AppExceptions implements Exception {
  final String message;

  AppExceptions({this.message});
}

class GenericException extends AppExceptions {
  GenericException({String message}) : super(message: message);
}

class UnAuthenticatedException extends AppExceptions {
  UnAuthenticatedException({String message}) : super(message: message);
}
