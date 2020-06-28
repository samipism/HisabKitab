part of 'specificformdata_bloc.dart';

abstract class SpecificformdataEvent extends Equatable {
  const SpecificformdataEvent();
}

class GetSpecificformdata extends SpecificformdataEvent {
  List<Object> get props => [];
  final DateTime date;
  const GetSpecificformdata(this.date);
}
