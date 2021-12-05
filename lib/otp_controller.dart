import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_login_test/home_screen.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPControllerScreen extends StatefulWidget {
  const OTPControllerScreen({Key? key, required this.phone, required this.codeDigits, required this.action}) : super(key: key);

  final String phone;
  final String codeDigits;
  final String action;

  @override
  _OTPControllerScreenState createState() => _OTPControllerScreenState();
}

class _OTPControllerScreenState extends State<OTPControllerScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPController = TextEditingController();
  final FocusNode _pinOTPFocus = FocusNode();
  String? verificationCode;

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
    color: Colors.blueAccent,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.grey
    )
  );

  @override
  void initState() {
    super.initState();
    print(widget.action);
    verifyPhoneNumber();
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.codeDigits + widget.phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        if(widget.action == 'login') {
          // print('kok login yang ini');
          await FirebaseAuth.instance.signInWithCredential(credential)
              .then((value) =>
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomeScreen())
              ));
        }
        else if(widget.action == 'reset') {
          // print('kok reset yang ini');
          await FirebaseAuth.instance.currentUser!.updatePhoneNumber(credential)
              .then((value) =>
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomeScreen())
              ));
        }
      },
      verificationFailed: (FirebaseAuthException error) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message.toString()),
            duration: Duration(seconds: 3),
          )
        );
      },
      codeSent: (String vID, int? resentToken) {
        setState(() {
          verificationCode = vID;
        });
      },
      codeAutoRetrievalTimeout: (String vID) {
        setState(() {
          verificationCode = vID;
        });
      },
      timeout: Duration(seconds: 60)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
          ),

          Container(
            margin: EdgeInsets.only(top: 20),
            child: Center(
              child: GestureDetector(
                onTap: () {

                },
                child: Text(
                  'verifying : ${widget.codeDigits}-${widget.phone}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(40),
            child: PinPut(
              fieldsCount: 6,
              textStyle: TextStyle(
                fontSize: 25,
                color: Colors.white
              ),
              eachFieldWidth: 40,
              eachFieldHeight: 55,
              focusNode: _pinOTPFocus,
              controller: _pinOTPController,
              submittedFieldDecoration: pinOTPCodeDecoration,
              selectedFieldDecoration: pinOTPCodeDecoration,
              followingFieldDecoration: pinOTPCodeDecoration,
              pinAnimationType: PinAnimationType.rotation,
              onSubmit: (pin) async {
                try {
                  if(widget.action=='login') {
                    print('lagi mau login');
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider
                        .credential(
                        verificationId: verificationCode!, smsCode: pin))
                        .then((value) {
                      if (value.user != null) {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen())
                        );
                      }
                    });
                  }
                  else if(widget.action == 'reset') {
                    print('lagi mau reset');
                    await FirebaseAuth.instance.currentUser!.updatePhoneNumber(PhoneAuthProvider
                        .credential(
                        verificationId: verificationCode!, smsCode: pin))
                        .then((value) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen())
                      );
                    });
                  }
                } catch(e) {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invalid OTP'),
                      duration: Duration(seconds: 3),
                    )
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
