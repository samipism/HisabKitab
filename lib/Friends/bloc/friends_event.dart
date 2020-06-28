part of 'friends_bloc.dart';

abstract class FriendsEvent extends Equatable {
  const FriendsEvent();
}

class GetAllFriends extends FriendsEvent {
  List<Object> get props => [];
}
