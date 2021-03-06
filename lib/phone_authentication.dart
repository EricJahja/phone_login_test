import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_login_test/otp_controller.dart';

class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({Key? key, required this.action}) : super(key: key);

  final String action;

  @override
  _PhoneAuthenticationState createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {

  String dialCodeDigits = '+62';
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.action);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100,),

            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Center(
                child: const Text(
                  'Phone (OTP) Verification',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50,),

            SizedBox(
              width: 400,
              height: 60,
              child: CountryCodePicker(
                onChanged: (country) {
                  setState(() {
                    dialCodeDigits = country.dialCode!;
                  });
                },
                initialSelection: 'ID',
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                favorite: const ["+62", "ID"],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  prefix: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(dialCodeDigits),
                  )
                ),
                maxLength: 12,
                keyboardType: TextInputType.number,
                controller: numberController,
              ),
            ),

            Container(
              margin: const EdgeInsets.all(15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => OTPControllerScreen(
                      phone: numberController.text,
                      codeDigits: dialCodeDigits,
                      action: widget.action,
                    )),
                  );
                },
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}