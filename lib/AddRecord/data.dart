// import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final num income;
  final num expenditure;
  final DateTime dateTime;
  final String friends;
  final String tags;
  final String description;
  Data(
      {this.income,
      this.expenditure,
      this.dateTime,
      this.friends,
      this.tags,
      this.description});
  @override
  List<Object> get props =>
      [income, expenditure, dateTime, friends, description, tags];
}
