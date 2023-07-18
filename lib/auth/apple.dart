import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:show_contakt/sample_page.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthButton extends StatelessWidget {
  const AppleAuthButton({super.key});

  Future<void> performAppleSignIn(BuildContext context) async {
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
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () async {
        performAppleSignIn(context);
      },
      child: SignInWithAppleButton(
        onPressed: () async {
          performAppleSignIn(context);
        },
      ),
    );
  }

}