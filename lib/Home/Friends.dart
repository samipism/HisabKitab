import 'package:flutter/material.dart';
import 'package:myproject/core/Contacts.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  Future<List<String>> _contacts;
  @override
  void initState() {
    super.initState();
    _contacts = ContactsManager().getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: FutureBuilder(
                future: _contacts,
                builder: (context, snapShot) {
                  if (snapShot.hasError) {
                    return Text(
                        "An Error Occured. May be due to Lack of Permission");
                  } else {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapShot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text("${snapShot.data[index]}"),
                          ),
                        );
                      },
                    );
                  }
                }))
      ],
    );
  }
}
