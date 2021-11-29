import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_login_test/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Link Email'),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut()
                      .then((value) => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const LoginScreen())
                  ));
                },
                child: const Text('Log out'))
            ],
          ),
      ),
      );
  }
}
