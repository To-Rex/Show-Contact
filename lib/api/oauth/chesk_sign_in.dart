import 'dart:convert';

import 'package:http/http.dart' as http;

class CheskSizgnIN{
  //https://show-contact-backend-production.up.railway.app//auth/login

  /*{
    "access_token": "sakmdlkmowekmeocmeorckecome",
    "id_token":"wqwqwew",
    "ids":"sdsdswea",
    "phone": "+998995340313",
    "email":"torex.amaki1@gmail.com",
    "password":"1234",
    "name":"xswxaewexxasdds",
    "photo_url":"sawsasedwedwededs",
    "blocked": true,
    "role":"users",
    "region":"region",
    "device": "android",
    "created_at":"2023-07-15 10:29:30",
    "updated_at":"2023-07-15 12:29:40"
}*/


  static Future<http.Response> login(String accessToken,String idToken,String ids,String phone,String email,String password,String name,String photoUrl,String role,String region,String device,String createdAt,String updatedAt) async {
    final response = await http.post(
      Uri.parse('https://show-contact-backend-production.up.railway.app/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,String>{
        'access_token': accessToken,
        'id_token': idToken,
        'ids': ids,
        'phone': phone,
        'email': email,
        'password': password,
        'name': name,
        'photo_url': photoUrl,
        'blocked': 'false',
        'role': role,
        'region': region,
        'device': device,
        'created_at': createdAt,
        'updated_at': updatedAt,
      }),
    );
    print(response.body);
    return response;
  }
}