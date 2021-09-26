import 'package:flutter/material.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const pageId = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: 100,
          ),
          Center(
            child: Container(
              height: 400,
              width: 400,
              child: SubmitButtonWidget(
                text: 'testtext',
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Center(
            child: ServeWidget(),
          )
        ],
      ),
    );
  }
}
