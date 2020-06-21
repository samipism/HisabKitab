part of 'formdata_bloc.dart';

abstract class FormdataEvent extends Equatable {
  const FormdataEvent();
}

class FormdataAddition extends FormdataEvent {
  List<Object> get props => [];
  final Data datum;
  const FormdataAddition(this.datum);
}
