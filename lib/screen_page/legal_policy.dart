import 'package:flutter/material.dart';
import 'package:projekuas/screen_page/setting_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LegalPoliciesScreen(),
    );
  }
}

class LegalPoliciesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF88B0F4),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>SettingsScreen())
                  );
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Legal and Policy',
              style: TextStyle(),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(Icons.list, size: 50),
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFF88B0F4), // Warna ungu latar belakang
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Terms',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Terms jwdhbkasjdbkajsbdans cals ashnijnsinc sjiijijnss skkahkandjs nn sjkkansnamce ajscja skjsjkjsjc sjcssssssssssssssssss s ssssssssssssssssss ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 16.0),
            Text(
              'Changes to the service and/or Terms:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Terms jwdhbkasjdbkajsbdans cals ashnijnsinc sjiijijnss skkahkandjs nn sjkkansnamce ajscja skjsjkjsjc sjcssssssssssssssssss s ssssssssssssssssss ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
