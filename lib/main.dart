import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:new_homework/sign_in%20screens/sign_in.dart';
import 'package:new_homework/sign_in%20screens/sign_up.dart';
import 'localized_strings.dart'; // Adjust import path as necessary
import 'drawer.dart'; // Import the drawer.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>()!;
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en', 'US');

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homework App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('fr', 'FR'),
        // Add more locales as needed
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        LocalizedStrings.delegate, // Use custom delegate
        // Add more delegates if needed
      ],
      locale: _locale,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return locale;
          }
        }
        return supportedLocales.first;
      },
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/signIn': (context) => SignInScreen(),
        '/signUp': (context) => SignUpScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizedStrings.of(context)!.translate('appTitle')!),
      ),
      drawer: AppDrawer(currentRoute: '/'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocalizedStrings.of(context)!.translate('welcomeMessage')!),
            ElevatedButton(
              onPressed: () => _showLanguageDialog(context),
              child: Text('Switch Language'),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageButton(context, 'English', Locale('en', 'US')),
              _buildLanguageButton(context, 'French', Locale('fr', 'FR')),
              // Add more languages as needed
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageButton(
      BuildContext context, String languageName, Locale locale) {
    return TextButton(
      child: Text(languageName),
      onPressed: () {
        MyApp.of(context).setLocale(locale);
        Navigator.pop(context);
      },
    );
  }
}
