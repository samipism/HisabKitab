// import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:myproject/core/Database.dart';

class Data extends Equatable {
  num id;
  final num income;
  final num expenditure;
  final DateTime dateTime;
  final String friends;
  final String tags;
  final String description;
  Data(
      {this.id,
      this.income,
      this.expenditure,
      this.dateTime,
      this.friends,
      this.tags,
      this.description});
  @override
  List<Object> get props =>
      [income, expenditure, dateTime, friends, description, tags];
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_DATETIME: this.dateTime.toIso8601String(),
      DatabaseProvider.COLUMN_DESCRIPTION: this.description,
      DatabaseProvider.COLUMN_FRIENDS: this.friends,
      DatabaseProvider.COLUMN_EXPENDITURE: this.expenditure,
      DatabaseProvider.COLUMN_INCOME: this.income,
      DatabaseProvider.COLUMN_TAGS: this.tags
    };
    if (id != null) map[DatabaseProvider.COLUMN_ID] = this.id;
    return map;
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    num id = map[DatabaseProvider.COLUMN_ID];
    num income = map[DatabaseProvider.COLUMN_INCOME];
    num expenditure = map[DatabaseProvider.COLUMN_EXPENDITURE];
    DateTime dateTime = DateTime.parse(map[DatabaseProvider.COLUMN_DATETIME]);
    String friends = map[DatabaseProvider.COLUMN_FRIENDS];
    String tags = map[DatabaseProvider.COLUMN_TAGS];
    String description = map[DatabaseProvider.COLUMN_DESCRIPTION];
    return Data(
        id: id,
        income: income,
        expenditure: expenditure,
        dateTime: dateTime,
        friends: friends,
        tags: tags,
        description: description);
  }
}
