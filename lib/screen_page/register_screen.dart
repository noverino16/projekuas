import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projekuas/model/modelRegister.dart';
import 'package:projekuas/model/modelVerify.dart';
import 'package:projekuas/screen_page/login_screen.dart';
import 'package:projekuas/screen_page/verification_screen.dart';
import 'package:projekuas/url/ip.dart';
import 'package:projekuas/url/session.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<ModelRegister?> registerAccount() async {
    try {
      if (!mounted) return null;
      setState(() {
        isLoading = true;
      });

      http.Response res =
          await http.post(Uri.parse('$ip/register.php'), body: {
        "username": _usernameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
      });

      if (!mounted) return null;
      ModelRegister data = modelRegisterFromJson(res.body);
      if (data.value == 1) {
        if (!mounted) return null;
        setState(() {
          isLoading = false;
        });
        session.saveSession(data.value ?? 0, data.username ?? "",
            data.email ?? "", data.status ?? "");
        OTPsend();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => VerificationScreen()),
            (route) => false);
      } else {
        if (!mounted) return null;
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${data.message}')));
      }
    } catch (e) {
      if (!mounted) return null;
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return null;
  }

  Future<ModelVerify?> OTPsend() async {
    try {
      if (!mounted) return null;
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(Uri.parse('$ip/otp_send.php'),
          body: {"email": _emailController.text});

      if (!mounted) return null;
      ModelVerify data = modelVerifyFromJson(res.body);
      if (data.value == 1) {
        if (!mounted) return null;
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Code OTP dikirim ke email anda')));
      } else {
        if (!mounted) return null;
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${data.message}')));
      }
    } catch (e) {
      if (!mounted) return null;
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Image.asset('gambar/logo.png'),
                ),
                SizedBox(height: 25,),
                Text(
                  'Register',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  'create an account to start access',
                  style: TextStyle(fontSize: 15,),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.person_outline),
                    SizedBox(width: 5),
                    Text(
                      "Username",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    hintText: 'Create your username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.email_outlined),
                    SizedBox(width: 5),
                    Text(
                      "Email",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    hintText: 'enter your email or phone number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.lock_outline),
                    SizedBox(width: 5),
                    Text(
                      "Password",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    hintText: 'Create your password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? please ',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'SIGN IN ',
                          style: TextStyle(
                            fontSize: 13,fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_usernameController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('All fields are required!')),
                        );
                      } else {
                        registerAccount();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
