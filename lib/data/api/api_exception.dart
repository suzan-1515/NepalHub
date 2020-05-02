class APIException implements Exception {
  final String message;

  APIException(this.message);

  @override
  String toString() => this.message;
}
