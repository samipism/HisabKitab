import 'package:flutter/material.dart';
import 'package:myproject/Home/TotalData.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Hisab"),
            centerTitle: true,
            backgroundColor: Colors.red[600]),
        body: Column(
          children: <Widget>[
            TotalData(),
            Row(
              children: <Widget>[],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[600],
          child: Text('click'),
          onPressed: () {
            print("You Clicked me!!!");
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
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
