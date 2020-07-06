import 'package:flutter/material.dart';
import 'package:myproject/AddRecord/Forms.dart';

class Expenditure extends StatefulWidget {
  @override
  _ExpenditureState createState() => _ExpenditureState();
}

class _ExpenditureState extends State<Expenditure> {
  @override
  Widget build(BuildContext context) {
    return FormInput(formType: "Expenditure");
  }
}
