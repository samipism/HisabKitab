import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/Friends/bloc/friends_bloc.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  Future<List<String>> _contacts;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FriendsBloc>(context).add(GetAllFriends());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsBloc, FriendsState>(
      builder: (context, state) {
        return Column(
          children: <Widget>[
            Expanded(child: BlocBuilder<FriendsBloc, FriendsState>(
                builder: (context, state) {
              if (state is FriendsSuccess) {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text("${state.data[index].name}"),
                          subtitle: Row(
                            children: <Widget>[
                              Icon(
                                state.data[index].income <
                                        state.data[index].expenditure
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: state.data[index].income <
                                        state.data[index].expenditure
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              Text(
                                "${state.data[index].income > state.data[index].expenditure ? state.data[index].income - state.data[index].expenditure : state.data[index].expenditure - state.data[index].income}",
                                style: TextStyle(
                                  color: state.data[index].income <
                                          state.data[index].expenditure
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Text("Something is wrong");
              }
            }))
          ],
        );
      },
    );
  }
}
