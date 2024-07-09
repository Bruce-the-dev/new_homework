import 'package:flutter/material.dart';
import 'package:new_homework/sign_in%20screens/sign_in.dart';
import 'package:new_homework/sign_in%20screens/sign_up.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/signIn': (context) => SignInScreen(),
        '/signUp': (context) => SignUpScreen(),
        // '/calculator': (context) => CalculatorScreen(),
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
      drawer: AppDrawer(currentRoute: '/'),
      body: Container(
        color: const Color.fromARGB(255, 196, 186,
            186), // Set a solid background color, for example, white
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
