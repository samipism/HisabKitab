import 'package:equatable/equatable.dart';

class FriendsModel extends Equatable {
  final num income;
  final num expenditure;
  final String name;
  FriendsModel({this.income, this.expenditure, this.name});
  factory FriendsModel.fromMap(Map<String, dynamic> map) {
    FriendsModel _model = FriendsModel(
        income: map["Income"],
        expenditure: map["Expenditure"],
        name: map["friend"]);
    return _model;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "friend": this.name,
      "Expenditure": this.expenditure,
      "Income": this.income
    };
    return map;
  }

  List<Object> get props => [income, expenditure, name];
}
