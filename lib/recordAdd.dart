import 'package:flutter/material.dart';

class AddRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Add Records"),
            bottom: TabBar(tabs: [
              Tab(
                text: "Income",
              ),
              Tab(text: "Expenditure")
            ]),
          ),
          body: TabBarView(
            children: <Widget>[Income(), Expenditure()],
          )),
    );
  }
}

class Expenditure extends StatefulWidget {
  @override
  _ExpenditureState createState() => _ExpenditureState();
}

class _ExpenditureState extends State<Expenditure> {
  String entryDate;

  @override
  void initState() {
    super.initState();
    entryDate = DateTime.now().toString().split(" ")[0];
  }

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
                  entryDate = date.toString().split(" ")[0];
                });
              },
              child: Text("Enter Date: $entryDate")),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Description",
            ),
          )
        ],
      ),
    );
  }
}

class Income extends StatefulWidget {
  @override
  _IncomeState createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Income"));
  }
}
