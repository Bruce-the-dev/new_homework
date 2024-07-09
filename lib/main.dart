import 'package:flutter/material.dart';
import 'package:new_homework/sign_in.dart';
import 'package:new_homework/sign_up.dart';
import 'drawer.dart'; // Import the drawer.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homework App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Initial route to MainScreen
      routes: {
        '/': (context) => MainScreen(), // Main screen route
        '/signIn': (context) => SignInScreen(), // Sign-in screen route
        '/signUp': (context) => SignUpScreen(), // Sign-up screen route
        // '/calculator': (context) =>
        //     CalculatorScreen(), // Calculator screen route
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homework App'),
      ),
      drawer: AppDrawer(currentRoute: '/'), // Drawer with current route '/'
      body: Container(
        color: Colors.white, // Set a solid background color, for example, white
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the Home Page! 👋🏾🌟',
                style: TextStyle(fontSize: 24.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
