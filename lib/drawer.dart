import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  AppDrawer({required this.currentRoute});

  Future<void> _selectProfilePicture(BuildContext context) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Handle the picked image (save it, display it, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected image: ${pickedFile.path}')),
      );
    }
  }

  Future<void> _takeProfilePicture(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Handle the picked image (save it, display it, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Took picture: ${pickedFile.path}')),
      );
    }
  }

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
              backgroundImage: AssetImage(
                  'images/profile_picture.png'), // Display your current profile picture
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
            icon: Icons.photo,
            text: 'Edit Profile Picture',
            onTap: () {
              _showEditProfilePictureDialog(context);
            },
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
    String? routeName,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap ??
          () {
            if (routeName != null && currentRoute != routeName) {
              Navigator.of(context).pushReplacementNamed(routeName);
            }
          },
    );
  }

  void _showEditProfilePictureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile Picture'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Select from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _selectProfilePicture(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Picture'),
                onTap: () {
                  Navigator.pop(context);
                  _takeProfilePicture(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
