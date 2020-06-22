import 'package:flutter/material.dart';
import 'package:myproject/AddRecord/bloc/formdata_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TotalData extends StatelessWidget {
  final date_format = DateFormat("MMMMEEEEd");
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<FormdataBloc, FormdataState>(
        builder: (context, state) {
          if (state is FormdataSuccess) {
            return Column(
              children: <Widget>[
                Card(
                  child: Text("You have : रू. ${state.total}"),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
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
                              " रू. ${state.data[index].expenditure == 0 ? state.data[index].income : state.data[index].expenditure}"),
                          trailing: Text(
                              "${date_format.format(state.data[index].dateTime)}"),
                        ),
                      );
                    },
                    itemCount: state.data.length,
                  ),
                ),
              ],
            );
          } else {
            return Text("Empty");
          }
        },
      ),
    );
  }
}
