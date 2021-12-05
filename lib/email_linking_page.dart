import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:phone_login_test/home_screen.dart';

class EmailLinkingPage extends StatefulWidget {
  const EmailLinkingPage({Key? key}) : super(key: key);

  @override
  _EmailLinkingPageState createState() => _EmailLinkingPageState();
}

class _EmailLinkingPageState extends State<EmailLinkingPage> {

  User? user = FirebaseAuth.instance.currentUser;
  late String email;
  late Timer timer;

  void checkEmailVerified() {
    if(user!.emailVerified){
      print('Email has been linked');
      timer.cancel();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

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
          ElevatedButton(
            child: Text('Link with Email'),
            onPressed: () async {
              if(email != null) {
                try {
                  await user!.linkWithCredential(EmailAuthProvider.credential(
                      email: email,
                      password: '123456')
                  );
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                } catch(e) {
                  print(e);
                }
              }
            },
          ),
          ElevatedButton(
            child: Text('Verify Email'),
            onPressed: () async {
              await user!.sendEmailVerification();
              timer = Timer.periodic(Duration(seconds: 5), (timer) {
                user!.reload();
                user = FirebaseAuth.instance.currentUser;
                checkEmailVerified();
                print(user!.emailVerified);
              });
            }
          ),
          ElevatedButton(
              child: Text('Update Email'),
              onPressed: () async {
                await user!.updateEmail(email);
                await user!.reload();
                print(user!.emailVerified);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
              }
          )
        ]
      ),
    );
  }
}
