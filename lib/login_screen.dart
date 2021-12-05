import 'package:flutter/material.dart';
import 'package:phone_login_test/email_authentication.dart';
import 'package:phone_login_test/phone_authentication.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: ElevatedButton(
              child: Text('Log In with email'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmailAuthentication())
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text('Log In with Phone Number'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhoneAuthentication(action: 'login'))
                );
              },
            ),
          ),
        ]
      )
    );
  }
}
