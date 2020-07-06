import 'package:flutter/material.dart';
import 'package:myproject/AddRecord/bloc/formdata_bloc.dart';
import 'package:myproject/AddRecord/bloc/specificformdata_bloc.dart';
import 'package:myproject/AddRecord/recordAdd.dart';
import 'package:myproject/Friends/bloc/friends_bloc.dart';
import 'package:myproject/Home/Home.dart';
import 'package:myproject/Introduction/Introduction.dart';
import 'package:myproject/core/Settings.dart';
import 'package:myproject/Theme.dart';
import 'package:myproject/bloc/tags_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TagsBloc(),
          ),
          BlocProvider(
            create: (context) => FormdataBloc(),
          ),
          BlocProvider(
            create: (context) =>
                SpecificformdataBloc(BlocProvider.of<FormdataBloc>(context)),
          ),
          BlocProvider(
            create: (context) => FriendsBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: BasicTheme.mainTheme,
          initialRoute: "/intro",
          routes: {
            "/intro": (context) => Introduction(),
            "/": (context) => Home(),
            "/addrecord": (context) => AddRecord(),
            "/settings": (context) => Settings()
          },
        )));
