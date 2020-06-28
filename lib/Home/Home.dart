import 'package:flutter/material.dart';
import 'package:myproject/Friends/Friends.dart';
import 'package:myproject/Stats/Stats.dart';
import 'package:myproject/Home/TotalData.dart';
import 'package:myproject/Home/User.dart';
import 'package:myproject/core/Database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  List<Widget> _children = [TotalData(), Stats(), Friends(), User()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.pushNamed(context, "/settings");
                  }),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.zero, bottom: Radius.circular(20))),
            title: Text("Hisab"),
            centerTitle: true),
        body: _children[_index],
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "/addrecord");
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (value) {
            setState(() {
              _index = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.label),
              title: Text('Stats'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_add),
              title: Text('Friends'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('User'),
            ),
          ],
        ));
  }
}
