import 'package:flutter/material.dart';
import 'package:myproject/AddRecord/Expenditure.dart';
import 'package:myproject/AddRecord/Income.dart';

class AddRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
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
