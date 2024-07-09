import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  AppDrawer({required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Bruce'),
            accountEmail: Text('bruce@work.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/profile_picture.png'),
            ),
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.home,
            text: 'Home',
            routeName: '/',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.person_add,
            text: 'Sign In',
            routeName: '/signIn',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.person_add,
            text: 'Sign Up',
            routeName: '/signUp',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.calculate,
            text: 'Calculator',
            routeName: '/calculator',
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String text,
    required String routeName,
  }) {
    bool isActive = currentRoute == routeName;

    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? Colors.blue : null,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.blue : null,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isActive,
      onTap: () {
        if (currentRoute != routeName) {
          Navigator.of(context).pushReplacementNamed(routeName);
        }
      },
    );
  }
}
