import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';

class DrawerSideMenu extends StatelessWidget {
  const DrawerSideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Provider.of<FirebaseAuthState>(context, listen: false)
                      .signOut();
              },
            ),
          )
        ]),
      ),
    );
  }
}