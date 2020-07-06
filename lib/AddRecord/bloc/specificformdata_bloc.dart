import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myproject/AddRecord/bloc/formdata_bloc.dart';
import 'package:myproject/AddRecord/data.dart';
import 'package:myproject/core/Database.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'specificformdata_event.dart';
part 'specificformdata_state.dart';

class SpecificformdataBloc
    extends Bloc<SpecificformdataEvent, SpecificformdataState> {
  List<Data> data = [];
  num income, expenditure;
  String curr;
  FormdataBloc formBloc;

  SpecificformdataBloc(this.formBloc) {
    this.formBloc.listen((state) {
      if (state is FormdataSuccess || state is FormdataEmpty) {
        this.add(GetSpecificformdata(DateTime.now()));
      }
    });
  }
  Future<String> _currencyFind() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    return _shared.getString("Country") ?? "Nepal:NPR";
  }

  num calulateIncome(List<Data> data) {
    return data
        .map((datum) => (datum.income))
        .toList()
        .fold(0, (previousValue, element) => previousValue + element);
  }

  num calulateExpenditure(List<Data> data) {
    return data
        .map((datum) => (datum.expenditure))
        .toList()
        .fold(0, (previousValue, element) => previousValue + element);
  }

  @override
  SpecificformdataState get initialState => SpecificformdataInitial();

  @override
  Stream<SpecificformdataState> mapEventToState(
    SpecificformdataEvent event,
  ) async* {
    if (event is GetSpecificformdata) {
      curr = await _currencyFind();
      data = await DatabaseProvider.db.getRecords() ?? [];
      data = data
          .where((element) =>
              element.dateTime.toString().split(" ")[0] ==
              event.date.toString().split(" ")[0])
          .toList();
      income = calulateIncome(data);
      expenditure = calulateExpenditure(data);
      if (data.length != 0) {
        yield SpecificformdataSuccess(
            [...data], income, expenditure, curr.split(":")[1]);
      } else {
        yield SpecificformdataEmpty();
      }
    }
  }
}
