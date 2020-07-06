import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatelessWidget {
  Future<String> getName() async {
    SharedPreferences _share = await SharedPreferences.getInstance();
    String _name = _share.getString("Username");
    return _name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: FutureBuilder<String>(
              future: getName(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(child: Text("${snapshot.data}"));
                } else {
                  return Text("Some Error occured.");
                }
              }),
        ),
      ],
    );
  }
}
