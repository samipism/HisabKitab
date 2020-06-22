import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myproject/AddRecord/data.dart';

part 'formdata_event.dart';
part 'formdata_state.dart';

class FormdataBloc extends Bloc<FormdataEvent, FormdataState> {
  List<Data> data = [];
  int total;
  @override
  FormdataState get initialState => FormdataInitial();

  @override
  Stream<FormdataState> mapEventToState(
    FormdataEvent event,
  ) async* {
    if (event is FormdataAddition) {
      data.insert(0, event.datum);
      print(data);
      total = data
          .map((datum) => (datum.income + (0 - datum.expenditure)))
          .toList()
          .fold(0, (previousValue, element) => previousValue + element);
      yield FormdataSuccess([...data], total);
    }
  }
}
