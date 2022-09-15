import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/commons/commons.dart';
import 'package:firebase_auth_app/dashboard.dart';
import 'package:flutter/material.dart';

import 'mobile_add_page.dart';

class OTPpage extends StatefulWidget {
  const OTPpage({Key? key}) : super(key: key);

  @override
  State<OTPpage> createState() => _OTPpageState();
}

class _OTPpageState extends State<OTPpage> {
  late TextEditingController otpController;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    otpController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                maxLength: 6,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter OTP ',
                ),
                controller: otpController,
                validator: (otp) {
                  return otpController.text.length == 6 ? null : 'Invalid OTP';
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
                          try {
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                              verificationId: MobileAddPage.verify,
                              smsCode: otpController.text,
                            );

                            // Sign the user in (or link) with the credential
                            await auth.signInWithCredential(credential);
                            Timer(
                              const Duration(seconds: 2),
                              () {
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            );

                            // ignore: use_build_context_synchronously
                            pushNavigation(context, const Dashboard());
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                              otpController.clear();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid OTP'),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text('Verify OTP'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
