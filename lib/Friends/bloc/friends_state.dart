part of 'friends_bloc.dart';

abstract class FriendsState extends Equatable {
  const FriendsState();
}

class FriendsInitial extends FriendsState {
  @override
  List<Object> get props => [];
}

class FriendsSuccess extends FriendsState {
  List<FriendsModel> data;
  @override
  FriendsSuccess(this.data);
  List<Object> get props => [data];
}

class FriendsLoading extends FriendsState {
  @override
  List<Object> get props => [];
}
