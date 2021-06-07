import 'package:flutter/material.dart';
import 'package:quotes_app/constants.dart';
import 'package:quotes_app/login_page.dart';
import 'package:quotes_app/quote_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: getInitialScreen(),
    );
  }

  Widget getInitialScreen() {
    final isLoggedIn = Constants.prefs!.getBool("isLoggedIn");
    if (isLoggedIn ?? false) {
      return QuotesPage();
    } else {
      return LoginPage();
    }
  }
}
