import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotes_app/accounts.dart';
import 'package:quotes_app/constants.dart';
import 'package:quotes_app/quote_page.dart';

class LoginWidget extends StatefulWidget {
  @override
  LoginWidgetState createState() {
    return LoginWidgetState();
  }
}

class LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final _accounts = Accounts();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter some text";
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "something@gmail.com",
              labelText: "Email"
            )
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter some text";
              }
              return null;
            },
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
                hintText: "123456 or whatever", labelText: "Password")
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _isLoading ? null : onTapLogin,
          child: Text("Log in")
        )
      ]),
    );
  }

  void onTapLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    toggleLoadingState();
    final email = _emailController.text;
    final password = _passwordController.text;
    try {
      final account = await _accounts.authenticateByEmailAndPassword(email, password);
      toggleLoadingState();
      Constants.prefs!.setBool("isLoggedIn", true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QuotesPage()),
      );
    } catch(e) {
      toggleLoadingState();
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void toggleLoadingState() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }
}
