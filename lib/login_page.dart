import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:show_contakt/sample_page.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../api/oauth/googleapi.dart';
import 'auth/apple.dart';
import 'auth/google.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /*Future<void> performAppleSignIn(BuildContext context) async {
    final result = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    print('access token: ${result.authorizationCode}');
    print('email: ${result.email}');
    print('display name: ${result.givenName}');
    print('photo url: ${result.identityToken}');
    print('server auth code: ${result.identityToken}');
    if (result != null) {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => const SamplePage(),
        ),
      );
    } else {
      SnackBar snackBar = SnackBar(
        content: Text('Something went wrong. Please try again later.'),
        backgroundColor: Colors.black.withOpacity(0.8),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: const BoxConstraints(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 25.0,
                          ),
                          child: Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Exo',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        /*SizedBox(
                          height: 250,
                        ),*/
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                          ),
                          GoogleAuthButton(),
                          if (Platform.isIOS)
                            /*Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.02),
                              child: SignInWithAppleButton(
                                onPressed: () async {
                                  performAppleSignIn(context);
                                  },
                              ),
                            ),*/
                            const AppleAuthButton()

                        ],
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
