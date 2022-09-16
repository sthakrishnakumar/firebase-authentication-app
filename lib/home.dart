import 'package:firebase_auth_app/commons/commons.dart';
import 'package:firebase_auth_app/features/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'features/phone_auth/presentation/screens/mobile_add_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoggedIn = false;
  Map userObj = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                navigation(
                  context,
                  const MobileAddPage(),
                );
              },
              child: const Text('Phone Verification'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              onPressed: () {
                // final provider =
                //     Provider.of<GoogleSignInProvider>(context, listen: false);
                // provider.googleLogin();

                AuthService().signInWithGoogle();
              },
              label: const Text('Login with Google'),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            isLoggedIn
                ? Column(
                    children: [
                      Text('Name ${userObj["name"]}'),
                      Text(userObj["email"]),
                      TextButton(
                        onPressed: () {
                          FacebookAuth.instance.logOut().then((value) {
                            setState(() {
                              isLoggedIn = false;
                              userObj = {};
                            });
                          });
                        },
                        child: const Text('Log Out'),
                      ),
                    ],
                  )
                : ElevatedButton.icon(
                    icon: const FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      FacebookAuth.instance
                          .login(permissions: ["public_profile", "email"]).then(
                              (value) {
                        FacebookAuth.instance
                            .getUserData()
                            .then((userData) async {
                          setState(() {
                            isLoggedIn = true;
                            userObj = userData;
                          });
                        });
                      });
                    },
                    label: const Text('Login with Facebook'),
                  ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
