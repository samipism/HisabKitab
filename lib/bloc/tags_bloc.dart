import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  @override
  TagsState get initialState => TagsInitial();

  @override
  Stream<TagsState> mapEventToState(
    TagsEvent event,
  ) async* {
    // TODO: implement mapEventToState
    switch (event) {
      case TagsEvent.addTags:
      yield 
    }
  }
}
