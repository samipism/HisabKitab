import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:myproject/CountryCurrency.dart';

class Introduction extends StatefulWidget {
  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  final introKey = GlobalKey<IntroductionScreenState>();
  String _country;
  Future<String> _shared;
  @override
  void initState() {
    super.initState();
    _shared = _currencyFind();
    _userFind().then((value) {
      if (value != null) Navigator.of(context).pushReplacementNamed("/");
    });
  }

  Future<String> _currencyFind() async {
    SharedPreferences _share = await SharedPreferences.getInstance();
    return _share.getString("Country") ?? "Nepal:NPR";
  }

  Future<String> _userFind() async {
    SharedPreferences _share = await SharedPreferences.getInstance();
    return _share.getString("Username");
  }

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacementNamed("/");
  }

  // Widget _buildImage(String assetName) {
  //   return Align(
  //     child: Image.asset('assets/$assetName.jpg', width: 350.0),
  //     alignment: Alignment.bottomCenter,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    TextStyle bodyStyle = TextStyle(
        fontSize: 19.0, color: Theme.of(context).colorScheme.onPrimary);
    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onPrimary),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Theme.of(context).colorScheme.primary,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Hisab",
          body: "Your Personal Expense Tracker.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Update as you go",
          body: "Simple Interface to update income and Expenditure",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Report of Friends",
          body: "See your sharing with Friends more easily.",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "User's Name",
          bodyWidget: TextField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: "UserName",
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: Theme.of(context)
                  .inputDecorationTheme
                  .border
                  .copyWith(
                      borderSide: BorderSide(width: 1, color: Colors.white)),
              enabledBorder: Theme.of(context)
                  .inputDecorationTheme
                  .border
                  .copyWith(
                      borderSide: BorderSide(width: 0, color: Colors.white)),
            ),
            onSubmitted: (value) async {
              SharedPreferences inst = await SharedPreferences.getInstance();
              inst.setString("Username", value);
            },
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Select Your Country",
          bodyWidget: FutureBuilder<String>(
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
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
