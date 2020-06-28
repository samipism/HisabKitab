import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myproject/AddRecord/bloc/formdata_bloc.dart';
import 'package:myproject/AddRecord/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataList extends StatelessWidget {
  const DataList(
      {Key key,
      @required this.date_format,
      this.income,
      this.expenditure,
      this.data,
      this.currency})
      : super(key: key);

  final DateFormat date_format;
  final num income;
  final num expenditure;
  final List<Data> data;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Theme.of(context).colorScheme.surface,
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
                    .add(FormdataDeletion(data[index]));

                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("Transaction dismissed")));
              },
              child: Card(
                child: ListTile(
                  leading: Icon(
                    data[index].expenditure == 0
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: data[index].expenditure == 0
                        ? Colors.green
                        : Colors.red,
                  ),
                  subtitle: Text(
                      "${data[index].expenditure == 0 ? "By" : "To"}: ${data[index].friends}"),
                  title: Text(
                      " $currency ${data[index].expenditure == 0 ? data[index].income : data[index].expenditure}"),
                  trailing: Text("${date_format.format(data[index].dateTime)}"),
                ),
              ),
            );
          },
          itemCount: data.length,
        ),
      ),
    );
  }
}
