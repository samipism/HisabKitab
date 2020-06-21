part of 'tags_bloc.dart';

abstract class TagsState extends Equatable {
  const TagsState();
  @override
  List<Object> get props => [];
}

class TagsInitial extends TagsState {
  final List<String> tags;
  TagsInitial(this.tags);
  @override
  List<Object> get props => [tags];
}

class TagsStateLoading extends TagsState {
  @override
  String toString() => 'SearchStateLoading';
}

class TagsStateEmpty extends TagsState {
  const TagsStateEmpty();
}

class TagsStateSuccess extends TagsState {
  @override
  final List<String> tags;
  const TagsStateSuccess(this.tags);
  @override
  List<Object> get props => [tags];
}
