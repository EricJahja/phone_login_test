import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_login_test/home_screen.dart';

class EmailAuthentication extends StatefulWidget {
  const EmailAuthentication({Key? key}) : super(key: key);

  @override
  State<EmailAuthentication> createState() => _EmailAuthenticationState();
}

class _EmailAuthenticationState extends State<EmailAuthentication> {

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value;
            },
          ),
          SizedBox(height: 20),
          TextField(
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
          ),
          SizedBox(height: 50),
          ElevatedButton(
            child: Text('LOGIN'),
            onPressed: () async {
              try {
                final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                if(user != null) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen())
                  );
                }
              } catch(e) {
                print(e);
              }

            },
          ),
        ]
      )
    );
  }
}
