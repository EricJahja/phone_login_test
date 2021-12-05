import 'package:flutter/material.dart';
import 'package:phone_login_test/login_screen.dart';
import 'package:phone_login_test/phone_authentication.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: ElevatedButton(
              child: Text('REGISTER'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhoneAuthentication(action: 'login'))
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text('LOGIN'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen())
                );
              },
            ),
          ),
        ]
      ),
    );
  }
}
