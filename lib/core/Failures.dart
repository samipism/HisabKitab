import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class PermissionFailure extends Failure {
  List<Object> get props => [];
}
