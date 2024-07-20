
import 'package:flutter/material.dart';
import 'package:projekuas/screen_page/login_screen.dart';
import 'package:projekuas/screen_page/setting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? id, username, email;

  @override
  void initState() {
    super.initState();
    getSession();
  }

  @override
  void didUpdateWidget(Profile oldWidget) {
    super.didUpdateWidget(oldWidget);
    getSession();
  }

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
      username = pref.getString("username");
      email = pref.getString("email");
      print(id);
      print(username);
      print(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                Text(
                  'Profile User',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(),
                      ),
                    );
                    },
                    icon: Icon(Icons.format_list_bulleted_rounded))
              ],
            ),
            Center(
              child: Image.asset(
                'gambar/profile.png',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              '$username',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              '$email',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'LOGOUT',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
