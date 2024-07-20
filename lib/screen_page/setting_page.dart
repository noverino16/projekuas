import 'package:flutter/material.dart';
import 'package:projekuas/screen_page/change_password.dart';
import 'package:projekuas/screen_page/help_dupport.dart';
import 'package:projekuas/screen_page/language.dart';
import 'package:projekuas/screen_page/legal_policy.dart';
import 'package:projekuas/screen_page/navbar.dart';
import 'package:projekuas/screen_page/profile.dart';
import 'package:projekuas/screen_page/security.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SettingsScreen(),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF88B0F4),
          leading: IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NavBar(),
                )),
            icon: Icon(Icons.arrow_back),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Settings',
                style: TextStyle(),
              ),
            ],
          )),
      body: Container(
        color: Color(0xFF88B0F4), // Warna ungu latar belakang
        child: ListView(
          children: [
            _buildDecoratedTile(
              icon: Icons.person,
              text: 'Edit Profile',
              onTap: () {
                
                // Navigasi ke halaman Edit Profile
              },
            ),
            SizedBox(height: 10),
            _buildDecoratedTile(
              icon: Icons.lock,
              text: 'Change Password',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()),
                );
                // Navigasi ke halaman Change Password
              },
            ),
            SizedBox(height: 10),
            _buildDecoratedTile(
              icon: Icons.security,
              text: 'Security',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecurityPage()),
                );
              },
            ),
            SizedBox(height: 10),
            _buildDecoratedTile(
              icon: Icons.language,
              text: 'Language',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguagePage()),
                );
              },
            ),
            SizedBox(height: 10),
            Divider(color: Colors.white), // Divider untuk memisahkan bagian
            _buildDecoratedTile(
              icon: Icons.policy,
              text: 'Legal & Policies',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LegalPoliciesScreen()));
                // Navigasi ke halaman Legal & Policies
              },
            ),
            SizedBox(height: 20),
            _buildDecoratedTile(
              icon: Icons.help,
              text: 'Help & Support',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HelpSupportScreen()));
                // Navigasi ke halaman Help & Support
              },
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Logout
                },
                icon: Icon(Icons.logout, color: Colors.red),
                label: Text('Logout', style: TextStyle(color: Colors.red)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecoratedTile(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return Container(
      margin: EdgeInsets.only(
        left: 40,
        right: 40,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        // border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, color: Colors.black),
            title: Text(text, style: TextStyle(color: Colors.black)),
            onTap: onTap,
          ),
          Divider(color: Colors.black),
        ],
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(10),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.grey.withOpacity(0.5),
    //         spreadRadius: 2,
    //         blurRadius: 5,
    //         offset: Offset(0, 3), // changes position of shadow
    //       ),
    //     ],
    //   ),
    //   child: Column(
    //     children: [
    //       ListTile(
    //         leading: Icon(icon, color: Colors.white),
    //         title: Text(text, style: TextStyle(color: Colors.white)),
    //         onTap: onTap,
    //       ),
    //       Divider(color: Colors.white),
    //     ],
    //   ),
    // );
  }
}
