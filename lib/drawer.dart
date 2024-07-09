import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppDrawer extends StatefulWidget {
  final String currentRoute;

  AppDrawer({required this.currentRoute});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  File? _profileImage;

  Future<void> _selectProfilePicture(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected image: ${pickedFile.path}')),
        );
      }
    }
  }

  Future<void> _takeProfilePicture(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Took picture: ${pickedFile.path}')),
        );
      }
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
              backgroundImage: _profileImage != null
                  ? FileImage(_profileImage!)
                  : AssetImage('images/profile_picture.png') as ImageProvider,
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
            if (routeName != null && widget.currentRoute != routeName) {
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
