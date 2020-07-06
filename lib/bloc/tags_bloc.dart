import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  List<String> tags = [
    "House-hold",
    "Food",
    "Education",
    "Grocery",
    "Personal",
    "Utilities",
    "Medical",
    "Fuel",
    "Entertainment",
  ];
  @override
  TagsState get initialState => TagsInitial([...tags]);

  @override
  Stream<TagsState> mapEventToState(
    TagsEvent event,
  ) async* {
    if (event is TagsList) {
      if (tags.isEmpty) {
        TagsStateEmpty();
      } else
        yield TagsStateSuccess(tags);
    } else if (event is TagsAddition) {
      tags.add(event.tag);
      print("From Event: $tags");
      yield TagsStateSuccess([...tags]);
    }
  }
}
