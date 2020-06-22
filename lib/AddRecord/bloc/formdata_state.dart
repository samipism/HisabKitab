part of 'formdata_bloc.dart';

abstract class FormdataState extends Equatable {
  const FormdataState();
}

class FormdataInitial extends FormdataState {
  @override
  List<Object> get props => [];
}

class FormdataLoading extends FormdataState {
  @override
  List<Object> get props => [];
}

class FormdataSuccess extends FormdataState {
  final List<Data> data;
  final int total;
  @override
  List<Object> get props => [data];
  FormdataSuccess(this.data, this.total);
}

class FormdataError extends FormdataState {
  @override
  List<Object> get props => [];
}

class FormdataEmpty extends FormdataState {
  @override
  List<Object> get props => [];
}
