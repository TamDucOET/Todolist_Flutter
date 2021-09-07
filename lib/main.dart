import 'package:flutter/material.dart';
import 'package:to_do_list/pages/home.dart';

Future main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'TodoList';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          fontFamily: "Cairo",
          scaffoldBackgroundColor: Colors.white,
          textTheme: Theme.of(context)
              .textTheme
              .apply(displayColor: Color(0xFF222B45)),
        ),
        home: HomePage(),
      );
}
