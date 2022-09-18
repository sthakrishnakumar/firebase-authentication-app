import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../phone_verified_dashboard.dart';
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
  String codeValue = "";

  @override
  void initState() {
    otpController = TextEditingController();
    listenOTP();
    super.initState();
  }

  void listenOTP() async {
    await SmsAutoFill().listenForCode();
    log("OTP Listen Called");
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
              PinFieldAutoFill(
                currentCode: codeValue,
                decoration: const UnderlineDecoration(
                  colorBuilder: FixedColorBuilder(Colors.grey),
                ),
                onCodeChanged: (code) {
                  setState(() {
                    codeValue = code.toString();
                  });
                },
              
              ),
              const SizedBox(
                height: 20,
              ),
              // TextFormField(
              //   maxLength: 6,
              //   keyboardType: TextInputType.phone,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     hintText: 'Enter OTP ',
              //   ),
              //   controller: otpController,
              //   validator: (otp) {
              //     return otpController.text.length == 6 ? null : 'Invalid OTP';
              //   },
              // ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        // if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                            verificationId: MobileAddPage.verify,
                            smsCode: codeValue,
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
                          pushNavigation(
                              context, const PhoneVerifiedDashboard());
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
                        // }
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
