import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myproject/Friends/FriendsModel.dart';
import 'package:myproject/core/Database.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  List<FriendsModel> data;
  String curr;
  Future<String> _currencyFind() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    return _shared.getString("Country") ?? "Nepal:NPR";
  }

  @override
  FriendsState get initialState => FriendsInitial();
  @override
  Stream<FriendsState> mapEventToState(
    FriendsEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetAllFriends) {
      yield FriendsLoading();
      curr = curr = await _currencyFind();
      data = await DatabaseProvider.db.getFriendsRecords() ?? [];
      yield (FriendsSuccess([...data]));
    }
  }
}
