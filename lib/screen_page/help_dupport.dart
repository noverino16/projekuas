import 'package:flutter/material.dart';
import 'package:projekuas/screen_page/setting_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HelpSupportScreen(),
    );
  }
}

class HelpSupportScreen extends StatelessWidget {
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
                'Help and Support',
                style: TextStyle(),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(Icons.list,size: 50,),
              ),
            ],
          )),
      body: Container(
        color: Color(0xFF88B0F4), // Warna ungu latar belakang
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            ExpansionTile(
              title: Text('i want to help you', style: TextStyle(color: Colors.black)),
              children: <Widget>[
                ListTile(title: Text('Content 1', style: TextStyle(color: Colors.black))),
              ],
            ),
            ExpansionTile(
              title: Text('i want to help you', style: TextStyle(color: Colors.black)),
              children: <Widget>[
                ListTile(title: Text('Content 2', style: TextStyle(color: Colors.black))),
              ],
            ),
            ExpansionTile(
              title: Text('i want to help you', style: TextStyle(color: Colors.black)),
              children: <Widget>[
                ListTile(title: Text('Content 3', style: TextStyle(color: Colors.black))),
              ],
            ),
            ExpansionTile(
              title: Text('i want to help you', style: TextStyle(color: Colors.black)),
              children: <Widget>[
                ListTile(title: Text('Content 4', style: TextStyle(color: Colors.black))),
              ],
            ),
            SizedBox(height: 16.0),
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
