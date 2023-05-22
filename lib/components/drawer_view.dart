
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("John Doe"),
            accountEmail: Text("johndoe@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              backgroundImage: AssetImage('assets/images/person.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_2_outlined,
                color: Theme.of(context).textTheme.bodyText1!.color),
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/Profile_page');
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
          ),
          ListTile(
            leading: Icon(Icons.arrow_back,
                color: Theme.of(context).textTheme.bodyText1!.color),
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/login_or_register');
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
          )
        ],
      ),
    );
  }
}
