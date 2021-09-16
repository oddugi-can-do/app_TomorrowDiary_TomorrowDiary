import 'package:flutter/material.dart';
import 'package:myapp/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myapp/size.dart';
import 'package:myapp/theme.dart';

void main() {
  initializeDateFormatting('ko_KR', null).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme(constraints),
          initialRoute: "/home",
          routes: {
            "/home": (context) => HomeScreen(constraints: constraints),
          },
        );
      },
    );
  }
}
