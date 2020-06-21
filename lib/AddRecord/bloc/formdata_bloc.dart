import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myproject/AddRecord/data.dart';

part 'formdata_event.dart';
part 'formdata_state.dart';

class FormdataBloc extends Bloc<FormdataEvent, FormdataState> {
  List<Data> data = [];
  @override
  FormdataState get initialState => FormdataInitial();

  @override
  Stream<FormdataState> mapEventToState(
    FormdataEvent event,
  ) async* {
    if (event is FormdataAddition) {
      data.add(event.datum);
      yield FormdataSuccess(data);
    }
  }
}
