
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:show_contakt/api/oauth/chesk_sign_in.dart';
import 'package:show_contakt/sample_page.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({super.key});

  @override
  Widget build(BuildContext context) {

    //push sample page
    void pushSamplePage() {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => const SamplePage(),
        ),
      );
    }

    //error toast message
    _showToast(BuildContext context, String message) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red.withOpacity(0.8),
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
    }

    return CupertinoButton(
      onPressed: () async {
        var accessToken = '';
        var idToken = '';
        var ids = '';
        var phone = '';
        var email = '';
        var displayName = '';
        var photoUrl = '';
        var authHeaders = '';
        var serverAuthCode = '';


        GoogleSignIn().signIn().then((value) async {
          value!.authentication.then((googleKey) async {
            print('access token: ${googleKey.accessToken}');
            //print('id token: ${googleKey.idToken}');
            //print('server auth code: ${googleKey.serverAuthCode}');
            print('id: ${value.id}');
            print('email: ${value.email}');
            print('display name: ${value.displayName}');
            print('photo url: ${value.photoUrl}');
            print('auth headers: ${value.authHeaders}');
            print('server auth code: ${value.serverAuthCode}');

            accessToken = googleKey.accessToken.toString();
            idToken = googleKey.idToken.toString();
            ids = value.id.toString();
            email = value.email.toString();
            displayName = value.displayName.toString();
            photoUrl = value.photoUrl.toString();
            authHeaders = value.authHeaders.toString();
            serverAuthCode = value.serverAuthCode.toString();

            final response = await http.post(Uri.parse('https://show-contact-backend-production.up.railway.app/auth/login'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String,String>{
                'access_token': accessToken,
                'id_token': idToken,
                'ids': ids,
                'phone': '+998995340313',
                'email': email,
                'password': '1234',
                'name': displayName,
                'photo_url': photoUrl,
                'role': 'users',
                'region': 'region',
                'device': 'android',
                'created_at': '2023-07-15 00:29:30',
                'updated_at': '2023-07-15 12:29:40',
              }),
            );
            if (response.statusCode == 200) {
              pushSamplePage();
            } else {
              _showToast(context, 'Something went wrong. Please try again later.');
            }
          });

          if (value != null) {
            print('ok');
          }else{
            _showToast(context, 'Something went wrong. Please try again later.');
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
