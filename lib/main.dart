import 'package:flutter/material.dart';
import 'package:myproject/data.dart';
import 'package:myproject/dataBloc.dart';
import 'recordAdd.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

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

class TotalData extends StatelessWidget {
  final dataBloc = DataBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Data>>(
      initialData: [
        Data(
            income: 1000,
            expenditure: 0,
            dateTime: DateTime.now(),
            friends: "None")
      ],
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        }
        if (snapshot.hasData) {
          return Expanded(
            child: Scrollbar(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var post = snapshot.data[index];
                  return ListTile(
                    title: Text("${post.income}"),
                    subtitle: Text(post.friends),
                  );
                },
              ),
            ),
          );
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Text("No Post");
      },
      stream: dataBloc.updatedList,
    );
  }
}
