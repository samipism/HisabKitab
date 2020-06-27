import 'package:flutter/material.dart';
import 'package:myproject/AddRecord/bloc/formdata_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myproject/core/Permission.dart';

class TotalData extends StatefulWidget {
  @override
  _TotalDataState createState() => _TotalDataState();
}

class _TotalDataState extends State<TotalData> {
  final date_format = DateFormat("MMMMEEEEd");

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FormdataBloc>(context).add(GetAllFormdata());
    HandlePermission.permission
        .isContactPermitted()
        .then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormdataBloc, FormdataState>(
      builder: (context, state) {
        if (state is FormdataSuccess) {
          return Column(
            children: <Widget>[
              Card(
                child: Text(
                    "You have : ${state.currency} ${state.income - state.expenditure}"),
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.red,
                      ),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        BlocProvider.of<FormdataBloc>(context)
                            .add(FormdataDeletion(state.data[index]));
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Transaction dismissed")));
                      },
                      child: Card(
                        child: ListTile(
                          leading: Icon(
                            state.data[index].expenditure == 0
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: state.data[index].expenditure == 0
                                ? Colors.green
                                : Colors.red,
                          ),
                          subtitle: Text("${state.data[index].friends}"),
                          title: Text(
                              " ${state.currency} ${state.data[index].expenditure == 0 ? state.data[index].income : state.data[index].expenditure}"),
                          trailing: Text(
                              "${date_format.format(state.data[index].dateTime)}"),
                        ),
                      ),
                    );
                  },
                  itemCount: state.data.length,
                ),
              ),
            ],
          );
          // return Text("Empty");
        } else {
          return Text("Empty");
        }
      },
    );
  }
}
