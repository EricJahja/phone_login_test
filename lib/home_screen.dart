import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_login_test/email_linking_page.dart';
import 'package:phone_login_test/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reset_phone_number_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User? user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome, ${user!.email ?? user!.phoneNumber}'),
              Text(user!.emailVerified.toString()),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EmailLinkingPage())
                  );
                },
                child: const Text('Link Email'),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResetPhoneNumberPage())
                  );
                },
                child: const Text('Reset Phone Number'),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut()
                    .then((value) => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen())
                  ));
                },
                child: const Text('Log out'))
            ],
          ),
      ),
      );
  }
}
