import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailLinkingPage extends StatefulWidget {
  const EmailLinkingPage({Key? key}) : super(key: key);

  @override
  _EmailLinkingPageState createState() => _EmailLinkingPageState();
}

class _EmailLinkingPageState extends State<EmailLinkingPage> {

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: Text('Link with Google'),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
