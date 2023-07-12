
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:show_contakt/sample_page.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({super.key});

  @override
  Widget build(BuildContext context) {

    return CupertinoButton(
      onPressed: () async {

        /*final user = await GoogleSignInAPI.login();
        if (user == null) {

          SnackBar snackBar = SnackBar(
            content: Text('Something went wrong. Please try again later.'),
            backgroundColor: UltronColors.black.withOpacity(0.8),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        } else {
          Navigator.of(context).pushReplacement(
            CupertinoPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }*/
        GoogleSignIn().signIn().then((value) {
          value!.authentication.then((googleKey) {
            //print(value);
            print('access token: ${googleKey.accessToken}');
            print('id token: ${googleKey.idToken}');
            print('server auth code: ${googleKey.serverAuthCode}');
            print('id: ${value.id}');
            print('email: ${value.email}');
            print('display name: ${value.displayName}');
            print('photo url: ${value.photoUrl}');
            print('auth headers: ${value.authHeaders}');
            print('server auth code: ${value.serverAuthCode}');
          });

          if (value != null) {
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (context) => const SamplePage(),
              ),
            );
          }else{
            SnackBar snackBar = SnackBar(
              content: Text('Something went wrong. Please try again later.'),
              backgroundColor: Colors.black.withOpacity(0.8),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      },
      color: Colors.red,
      borderRadius: BorderRadius.circular(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*SvgPicture.asset(
            'assets/images/google.svg',
            width: MediaQuery.of(context).size.width * 0.06,
          ),*/
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),

          const Text('Continue with Google',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Exo',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ))
        ],
      ),
    );
  }
}
