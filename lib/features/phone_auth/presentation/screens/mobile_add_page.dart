import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/commons/commons.dart';
import 'package:flutter/material.dart';

import 'otp_page.dart';

class MobileAddPage extends StatefulWidget {
  const MobileAddPage({Key? key}) : super(key: key);

  static String verify = '';

  @override
  State<MobileAddPage> createState() => _MobileAddPageState();
}

class _MobileAddPageState extends State<MobileAddPage> {
  late TextEditingController phoneController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Add Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Phone Number',
                  prefix: Text('+977 '),
                ),
                controller: phoneController,
                validator: (phone) {
                  return phoneController.text.length == 10
                      ? null
                      : 'Invalid Phone Number';
                },
              ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '+977${phoneController.text}',
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent:
                                (String verificationId, int? resendToken) {
                              MobileAddPage.verify = verificationId;
                              pushNavigation(context, const OTPpage());
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                          );
                          Timer(
                            const Duration(seconds: 2),
                            () {
                              setState(() {
                                isLoading = false;
                              });
                            },
                          );
                        }
                      },
                      child: const Text('Send OTP'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
