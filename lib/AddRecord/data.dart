// import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final num income;
  final num expenditure;
  final DateTime dateTime;
  final String friends;
  Data({this.income, this.expenditure, this.dateTime, this.friends});
  @override
  List<Object> get props => [income, expenditure, dateTime, friends];
}
