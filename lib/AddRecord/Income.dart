import 'package:flutter/material.dart';
import 'package:myproject/AddRecord/bloc/formdata_bloc.dart';
import 'package:myproject/AddRecord/data.dart';
import 'package:myproject/bloc/tags_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Income extends StatefulWidget {
  const Income({
    Key key,
  }) : super(key: key);

  @override
  _IncomeState createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  DateTime entryDate;
  String tag;
  @override
  void initState() {
    super.initState();
    entryDate = DateTime.now();
    tag = "Selection";
  }

  TextEditingController _desc = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _friends = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          FlatButton(
              onPressed: () async {
                DateTime date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1970, 1, 1),
                    lastDate: DateTime.now());
                setState(() {
                  entryDate = date;
                });
              },
              child: Text("Enter Date: ${entryDate.toString().split(" ")[0]}")),
          BlocBuilder<TagsBloc, TagsState>(
            builder: (context, state) {
              if (state is TagsStateSuccess) {
                return DropdownButton(
                    isExpanded: true,
                    value: tag,
                    items: state.tags
                        .map((e) => DropdownMenuItem<String>(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (String s) {
                      setState(() {
                        tag = s;
                      });
                    });
              } else if (state is TagsInitial) {
                return DropdownButton(
                    isExpanded: true,
                    value: tag,
                    items: state.tags
                        .map((e) => DropdownMenuItem<String>(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (String s) {
                      setState(() {
                        tag = s;
                      });
                    });
              } else
                return Text("Some Error");
            },
          ),
          TextFormField(
            controller: _desc,
            decoration: InputDecoration(
              labelText: "Description",
            ),
          ),
          TextFormField(
            controller: _amount,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Amount",
            ),
          ),
          TextFormField(
            controller: _friends,
            decoration: InputDecoration(
              labelText: "Friends",
            ),
          ),
          RaisedButton(
            onPressed: () {
              BlocProvider.of<FormdataBloc>(context).add(FormdataAddition(Data(
                  description: _desc.text,
                  tags: tag,
                  income: int.parse(_amount.text),
                  expenditure: 0,
                  friends: _friends.text,
                  dateTime: entryDate)));
              _desc.clear();
              _amount.clear();
              _friends.clear();

              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text("Form Submitted Successfully.")));
            },
            child: Text('Submit'),
          )
        ],
      ),
    );
  }
}
