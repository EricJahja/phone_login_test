import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_login_test/phone_authentication.dart';

class ResetPhoneNumberPage extends StatefulWidget {
  const ResetPhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<ResetPhoneNumberPage> createState() => _ResetPhoneNumberPageState();
}

class _ResetPhoneNumberPageState extends State<ResetPhoneNumberPage> {
  User? user = FirebaseAuth.instance.currentUser;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(height: 30),
            TextField(
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
            ),
            ElevatedButton(
              child: Text('Re-authenticate'),
              onPressed: () async {
                if(email != null && password != null) {
                  try {
                    var credential = EmailAuthProvider.credential(email: email, password: password);
                    await user!.reauthenticateWithCredential(credential);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhoneAuthentication(action: 'reset')));
                  } catch(e) {
                    print(e);
                  }
                }
              },
            ),
          ]
      ),
    );
  }
}