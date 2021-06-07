import 'package:flutter/material.dart';
import 'package:quotes_app/quote_page.dart';

class LoginWidget extends StatefulWidget {
  @override
  LoginWidgetState createState() {
    return LoginWidgetState();
  }
}

class LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter some text";
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: "algo@gmail.com", labelText: "Email")),
        TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter some text";
              }
              return null;
            },
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
                hintText: "123456 or whatever", labelText: "Password")),
        ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuotesPage()),
                );
              }
            },
            child: Text("Log in"))
      ]),
    );
  }
}
