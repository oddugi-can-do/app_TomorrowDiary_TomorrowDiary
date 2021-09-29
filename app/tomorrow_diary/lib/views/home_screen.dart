import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/views/views.dart';

class HomeScreen extends StatefulWidget {
  static const pageId = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child:  Text("Tomorrow Diary", textAlign: TextAlign.center)),
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("LogOut"),
                onTap: (){
                    Provider.of<FirebaseAuthState>(context, listen:false).signOut();
                },
              ),
            ],
          ),
        ),
      ),
      body: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(), 
      )

        
    );
  }
}
