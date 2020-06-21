import 'package:flutter/material.dart';
import 'package:myproject/AddRecord/Expenditure.dart';
import 'package:myproject/AddRecord/Income.dart';
import 'package:myproject/AddRecord/bloc/formdata_bloc.dart';
import 'package:myproject/bloc/tags_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TagsBloc(),
          ),
          BlocProvider(
            create: (context) => FormdataBloc(),
          ),
        ],
        child: DefaultTabController(
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
        ));
  }
}
