import 'package:flutter/material.dart';
import 'package:myproject/AddRecord/bloc/formdata_bloc.dart';
import 'package:myproject/AddRecord/data.dart';
import 'package:myproject/bloc/tags_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/core/Contacts.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class FormInput extends StatefulWidget {
  final String formType;

  FormInput({this.formType});
  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  DateTime entryDate;
  Future<List<String>> _contacts;
  String tag;
  @override
  void initState() {
    super.initState();
    entryDate = DateTime.now();
    tag = "Food";
    _contacts = ContactsManager().getContacts();
  }

  TextEditingController _desc = TextEditingController();
  TextEditingController _amount = TextEditingController();
  String _friends;

  void onSubmitted() {
    if (widget.formType == "Expenditure") {
      BlocProvider.of<FormdataBloc>(context).add(FormdataAddition(Data(
          description: _desc.text,
          tags: tag,
          income: 0,
          expenditure: int.parse(_amount.text),
          friends: _friends,
          dateTime: entryDate)));
    } else if (widget.formType == "Income") {
      BlocProvider.of<FormdataBloc>(context).add(FormdataAddition(Data(
          description: _desc.text,
          tags: tag,
          income: int.parse(_amount.text),
          expenditure: 0,
          friends: _friends,
          dateTime: entryDate)));
    }

    _desc.clear();
    _amount.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            TextFormField(
                autofocus: true,
                textAlign: TextAlign.center,
                controller: _amount,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).nextFocus();
                },
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
              autofocus: true,
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
            BlocBuilder<TagsBloc, TagsState>(
              builder: (context, state) {
                if (state is TagsStateSuccess) {
                  return Wrap(
                      children: List<Widget>.generate(
                          state.tags.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ChoiceChip(
                                    onSelected: (value) {
                                      setState(() {
                                        tag = value ? state.tags[index] : tag;
                                      });
                                    },
                                    label: Text("${state.tags[index]}"),
                                    selected: tag == state.tags[index]),
                              )));
                } else if (state is TagsInitial) {
                  return Wrap(
                      children: List<Widget>.generate(
                          state.tags.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ChoiceChip(
                                    elevation: 2.0,
                                    selectedColor:
                                        widget.formType == "Expenditure"
                                            ? Colors.red
                                            : Colors.green[500],
                                    onSelected: (value) {
                                      setState(() {
                                        tag = value ? state.tags[index] : tag;
                                      });
                                    },
                                    label: Text("${state.tags[index]}"),
                                    selected: tag == state.tags[index]),
                              )));
                } else
                  return Text("Some Error");
              },
            ),
            SizedBox(
              height: 10,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                    color: widget.formType == "Expenditure"
                        ? Colors.red
                        : Colors.green),
                borderRadius: BorderRadius.circular(50),
              ),
              child: FutureBuilder<List<String>>(
                future: _contacts,
                initialData: [],
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SearchableDropdown.single(
                        style: TextStyle(
                          color: widget.formType == "Expenditure"
                              ? Colors.red
                              : Colors.green,
                        ),
                        // label: "Friends:",
                        isExpanded: true,
                        hint: Text("Friends"),
                        value: _friends,
                        items: snapshot.data
                            .map((e) => DropdownMenuItem(
                                value: "$e", child: Text("$e")))
                            .toList(),
                        onChanged: (value) async {
                          _friends = value;
                        });
                  } else {
                    return Text("Some Error Occured.");
                  }
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              color:
                  widget.formType == "Expenditure" ? Colors.red : Colors.green,
              onPressed: onSubmitted,
              child: Text('Submit'),
            ),
          ],
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
