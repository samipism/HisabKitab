import 'package:flutter/material.dart';
import 'package:myproject/AddRecord/bloc/formdata_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myproject/AddRecord/bloc/specificformdata_bloc.dart';
import 'package:myproject/Home/DataList.dart';

class TotalData extends StatefulWidget {
  @override
  _TotalDataState createState() => _TotalDataState();
}

class _TotalDataState extends State<TotalData> {
  final date_format = DateFormat("MMMMEEEEd");

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FormdataBloc>(context).add(GetAllFormdata());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: BlocBuilder<FormdataBloc, FormdataState>(
            builder: (context, state) {
              if (state is FormdataSuccess) {
                return Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_balance_wallet,
                          color: Theme.of(context).colorScheme.primary,
                          size: 50,
                        ),
                        Text(
                            "${state.currency} ${state.income - state.expenditure}"),
                      ],
                    ),
                    DataList(
                        date_format: date_format,
                        data: state.data,
                        currency: state.currency,
                        expenditure: state.expenditure,
                        income: state.income),
                  ],
                );
              } else if (state is FormdataEmpty) {
                return Card(
                  color: Theme.of(context).colorScheme.surface,
                  child: Center(
                    child: Text("No Transaction Occured Till Now."),
                  ),
                );
              } else {
                return Center(
                  child: SpinKitWave(
                    size: 50,
                    color: Colors.blue,
                  ),
                );
              }
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<SpecificformdataBloc, SpecificformdataState>(
            builder: (context, state) {
              if (state is SpecificformdataSuccess) {
                return Column(
                  children: <Widget>[
                    Container(
                      // color: Theme.of(context).colorScheme.secondary,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.only(
                      //         topLeft: Radius.circular(10),
                      //         topRight: Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Card(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                Text("${state.currency} ${state.income} "),
                              ],
                            ),
                          ),
                          Text("Today:"),
                          Card(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_downward,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                Text("${state.currency} ${state.expenditure}"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    DataList(
                        date_format: date_format,
                        data: state.data,
                        currency: state.currency,
                        expenditure: state.expenditure,
                        income: state.income),
                  ],
                );
              } else if (state is SpecificformdataEmpty) {
                return Card(
                  color: Theme.of(context).colorScheme.surface,
                  child: Center(
                    child: Text("No Transaction Occured Today."),
                  ),
                );
              } else
                return Center(
                  child: SpinKitRing(
                    size: 50,
                    color: Colors.blue,
                  ),
                );
            },
          ),
        ),
      ],
    );
  }
}
