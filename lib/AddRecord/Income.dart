import 'package:flutter/material.dart';
import 'package:myproject/core/Forms.dart';

class Income extends StatefulWidget {
  const Income({
    Key key,
  }) : super(key: key);

  @override
  _IncomeState createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  @override
  Widget build(BuildContext context) {
    return FormInput(
      formType: "Income",
    );
  }
}
