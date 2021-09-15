import 'package:flutter/material.dart';
import 'package:myapp/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myapp/size.dart';

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
          theme: ThemeData(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange.shade300,
                primary: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(constraints.maxWidth * 0.8, TDSize.withHeight(constraints).withSize(SizeList.s)),
                textStyle: TextStyle(fontSize: TDSize.withHeight(constraints).withSize(SizeList.xs)),
              ),
            ),
          ),
          initialRoute: "/home",
          routes: {
            "/home": (context) => HomeScreen(constraints: constraints),
          },
        );
      },
    );
  }
}
