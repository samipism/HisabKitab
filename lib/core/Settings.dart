import 'package:flutter/material.dart';
import 'package:myproject/CountryCurrency.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _country;
  Future<String> _shared;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _shared = _currencyFind();
  }

  Future<String> _currencyFind() async {
    SharedPreferences _share = await SharedPreferences.getInstance();
    return _share.getString("Country") ?? "Nepal:NPR";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<String>(
                future: _shared,
                initialData: "Nepal:NPR",
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SearchableDropdown.single(
                        label: "Enter Country Name:",
                        isExpanded: true,
                        hint: Text("Enter Country name:"),
                        value: snapshot.data,
                        items: countryList
                            .map((e) => DropdownMenuItem(
                                value: "${e["Country"]}:${e["Curr"]}",
                                child: Text("${e["Country"]}(${e["Curr"]})")))
                            .toList(),
                        onChanged: (value) async {
                          SharedPreferences inst =
                              await SharedPreferences.getInstance();
                          inst.setString("Country", value);
                        });
                  } else {
                    return Text("Some Error Occured.");
                  }
                },
              ),
            ),
          ],
        ));
  }
}
