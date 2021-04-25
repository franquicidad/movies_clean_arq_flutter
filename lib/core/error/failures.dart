import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

class ServerFailure extends Failure {
  final String serverFailure;

  ServerFailure({this.serverFailure});
}

class CacheFailure extends Failure {
  final String cacheFailure;

  CacheFailure({this.cacheFailure});
}
