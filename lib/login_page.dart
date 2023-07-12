import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../api/oauth/googleapi.dart';
import 'auth/google.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> performAppleSignIn(BuildContext context) async {
    final result = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    print(result);
    print(result.authorizationCode);
    print(result.email);
    print(result.givenName);
    print(result.identityToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: const BoxConstraints(),
                child:  Column(
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
                          vertical: 10.0,
                          horizontal: 25.0
                      ),
                      child: Column(
                        children: [SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                        ),
                          GoogleAuthButton(),
                          if (Platform.isIOS)
                            Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.02
                              ),
                              child: SignInWithAppleButton(
                                onPressed: () async {
                                  performAppleSignIn(context);

                                  // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                                  // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                                },
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                )
            ),
          ),
        )
    );
  }
}
