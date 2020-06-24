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
  final num income, expenditure;
  final String currency;
  @override
  List<Object> get props => [data, income, expenditure, currency];
  FormdataSuccess(this.data, this.income, this.expenditure, this.currency);
}

class FormdataError extends FormdataState {
  @override
  List<Object> get props => [];
}

class FormdataEmpty extends FormdataState {
  @override
  List<Object> get props => [];
}
