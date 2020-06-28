import 'package:flutter/material.dart';
import 'package:myproject/AddRecord/bloc/formdata_bloc.dart';
import 'package:myproject/AddRecord/bloc/specificformdata_bloc.dart';
import 'package:myproject/AddRecord/data.dart';
import 'package:myproject/bloc/tags_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormInput extends StatefulWidget {
  final String formType;

  FormInput({this.formType});
  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
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

  void onSubmitted() {
    if (widget.formType == "Expenditure") {
      BlocProvider.of<FormdataBloc>(context).add(FormdataAddition(Data(
          description: _desc.text,
          tags: tag,
          income: 0,
          expenditure: int.parse(_amount.text),
          friends: _friends.text,
          dateTime: entryDate)));
    } else if (widget.formType == "Income") {
      BlocProvider.of<FormdataBloc>(context).add(FormdataAddition(Data(
          description: _desc.text,
          tags: tag,
          income: int.parse(_amount.text),
          expenditure: 0,
          friends: _friends.text,
          dateTime: entryDate)));
    }

    _desc.clear();
    _amount.clear();
    _friends.clear();

    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Form Submitted Successfully.")));
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: Form(
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
                      entryDate = date ?? DateTime.now();
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.date_range),
                      Text("${entryDate.toString().split(" ")[0]}"),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<TagsBloc, TagsState>(
                builder: (context, state) {
                  if (state is TagsStateSuccess) {
                    return DropdownButtonFormField(
                        style: TextStyle(
                            color: widget.formType == "Expenditure"
                                ? Colors.red
                                : Colors.green),
                        decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: widget.formType == "Expenditure"
                                    ? Colors.red
                                    : Colors.green),
                            enabledBorder: Theme.of(context)
                                .inputDecorationTheme
                                .border
                                .copyWith(
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: widget.formType == "Expenditure"
                                            ? Colors.red
                                            : Colors.green)),
                            focusedBorder: Theme.of(context)
                                .inputDecorationTheme
                                .border
                                .copyWith(
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: widget.formType == "Expenditure"
                                            ? Colors.red
                                            : Colors.green))),
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
                    return DropdownButtonFormField(
                        style: TextStyle(
                            color: widget.formType == "Expenditure"
                                ? Colors.red
                                : Colors.green),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: widget.formType == "Expenditure"
                                  ? Colors.red
                                  : Colors.green),
                          enabledBorder: Theme.of(context)
                              .inputDecorationTheme
                              .border
                              .copyWith(
                                  borderSide: BorderSide(
                                      width: 0,
                                      color: widget.formType == "Expenditure"
                                          ? Colors.red
                                          : Colors.green)),
                          focusedBorder: Theme.of(context)
                              .inputDecorationTheme
                              .border
                              .copyWith(
                                  borderSide: BorderSide(
                                      width: 0,
                                      color: widget.formType == "Expenditure"
                                          ? Colors.red
                                          : Colors.green)),
                        ),
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
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _desc,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: widget.formType == "Expenditure"
                          ? Colors.red
                          : Colors.green),
                  labelText: "Description",
                  focusedBorder: Theme.of(context)
                      .inputDecorationTheme
                      .border
                      .copyWith(
                          borderSide: BorderSide(
                              width: 1,
                              color: widget.formType == "Expenditure"
                                  ? Colors.red
                                  : Colors.green)),
                  enabledBorder: Theme.of(context)
                      .inputDecorationTheme
                      .border
                      .copyWith(
                          borderSide: BorderSide(
                              width: 0,
                              color: widget.formType == "Expenditure"
                                  ? Colors.red
                                  : Colors.green)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  textAlign: TextAlign.center,
                  controller: _amount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Amount",
                    labelStyle: TextStyle(
                        color: widget.formType == "Expenditure"
                            ? Colors.red
                            : Colors.green),
                    focusedBorder: Theme.of(context)
                        .inputDecorationTheme
                        .border
                        .copyWith(
                            borderSide: BorderSide(
                                width: 1,
                                color: widget.formType == "Expenditure"
                                    ? Colors.red
                                    : Colors.green)),
                    enabledBorder: Theme.of(context)
                        .inputDecorationTheme
                        .border
                        .copyWith(
                            borderSide: BorderSide(
                                width: 0,
                                color: widget.formType == "Expenditure"
                                    ? Colors.red
                                    : Colors.green)),
                  )),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _friends,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: widget.formType == "Expenditure"
                          ? Colors.red
                          : Colors.green),
                  labelText: "Friends",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                color: widget.formType == "Expenditure"
                    ? Colors.red
                    : Colors.green,
                onPressed: onSubmitted,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amount.dispose();
    _desc.dispose();
    super.dispose();
  }
}
