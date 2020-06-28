part of 'specificformdata_bloc.dart';

abstract class SpecificformdataState extends Equatable {
  const SpecificformdataState();
}

class SpecificformdataInitial extends SpecificformdataState {
  @override
  List<Object> get props => [];
}

class SpecificformdataLoading extends SpecificformdataState {
  @override
  List<Object> get props => [];
}

class SpecificformdataSuccess extends SpecificformdataState {
  final List<Data> data;
  final num income, expenditure;
  final String currency;
  @override
  List<Object> get props => [data, income, expenditure, currency];
  SpecificformdataSuccess(
      this.data, this.income, this.expenditure, this.currency);
}

class SpecificformdataError extends SpecificformdataState {
  @override
  List<Object> get props => [];
}

class SpecificformdataEmpty extends SpecificformdataState {
  @override
  List<Object> get props => [];
}
