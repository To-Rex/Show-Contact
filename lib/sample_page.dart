import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({super.key});

  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage>
    with SingleTickerProviderStateMixin {
  Future<void> _askPermissions(String routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        print('routeName: $routeName');
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      print('denied');
      const snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      print('permanentlyDenied');
      const snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  @override
  void initState() {
    super.initState();
    _askPermissions('');
    getContacts();
  }

  // Name
  late String displayName, givenName, middleName, prefix, suffix, familyName;

// Company
  late String company;
  late String jobTitle;

// Email addresses
  List<Item> emails = [];

// Phone numbers
  List<Item> phones = [];

// Post addresses
  List<PostalAddress> postalAddresses = [];

// Contact avatar/thumbnail
  late Uint8List avatar;

  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  TextEditingController searchController = TextEditingController();
  String query = "";
  bool _permissionDenied = false;

  Future<void> getContacts() async {
    if (await Permission.contacts.request().isGranted) {
      print('granted');
      // Either the permission was already granted before or the user just granted it.
      Iterable<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        this.contacts = contacts.toList();
      });
      for (var i = 0; i < contacts.length; i++) {
        print(contacts.elementAt(i).displayName);
        print(contacts.elementAt(i).phones?.elementAt(0).value);
        print(contacts.elementAt(i).givenName);
        print(contacts.elementAt(i).familyName);
        print(contacts.elementAt(i).prefix);
        print(contacts.elementAt(i).suffix);
        print(contacts.elementAt(i).middleName);
        print(contacts.elementAt(i).company);
        print(contacts.elementAt(i).jobTitle);
        print(contacts.elementAt(i).postalAddresses);
        print(contacts.elementAt(i).emails);
      }
    } else {
      print('denied');
      setState(() {
        _permissionDenied = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0), // here the desired height
        child: AppBar(
          backgroundColor: const Color.fromRGBO(33, 158, 188, 10),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromRGBO(33, 158, 188, 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                onChanged: (value) {
                  //filterContacts();
                },
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                Contact contact = contacts[index];
                return ListTile(
                  title: Text(contact.displayName ?? ''),
                  subtitle: Text(contact.phones?.elementAt(0).value ?? ''),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

