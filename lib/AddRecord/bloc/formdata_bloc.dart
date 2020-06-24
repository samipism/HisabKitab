import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myproject/AddRecord/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'formdata_event.dart';
part 'formdata_state.dart';

class FormdataBloc extends Bloc<FormdataEvent, FormdataState> {
  List<Data> data = [];
  num income, expenditure;
  String curr;

  Future<String> _currencyFind() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    return _shared.getString("Country") ?? "Nepal:NPR";
  }

  @override
  FormdataState get initialState => FormdataInitial();

  @override
  Stream<FormdataState> mapEventToState(
    FormdataEvent event,
  ) async* {
    if (event is FormdataAddition) {
      yield FormdataLoading();
      curr = await _currencyFind();
      data.insert(0, event.datum);
      print(data);
      income = data
          .map((datum) => (datum.income))
          .toList()
          .fold(0, (previousValue, element) => previousValue + element);
      expenditure = data
          .map((datum) => (datum.expenditure))
          .toList()
          .fold(0, (previousValue, element) => previousValue + element);
      yield FormdataSuccess([...data], income, expenditure, curr.split(":")[1]);
    }
  }
}
