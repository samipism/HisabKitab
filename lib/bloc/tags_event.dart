part of 'tags_bloc.dart';

abstract class TagsEvent extends Equatable {
  const TagsEvent();
  @override
  List<Object> get props => [];
}

class TagsAddition extends TagsEvent {
  final String tag;
  const TagsAddition(this.tag);
  @override
  List<Object> get props => [tag];
}

class TagsList extends TagsEvent {
  const TagsList();
}
