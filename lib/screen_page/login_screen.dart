import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projekuas/model/modelLogin.dart';
import 'package:projekuas/screen_page/forgot_password_screen.dart';
import 'package:projekuas/screen_page/navbar.dart';
import 'package:projekuas/screen_page/register_screen.dart';
import 'package:projekuas/url/ip.dart';
import 'package:projekuas/url/session.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLoading = false;

  Future<ModelLogin?> loginAccount() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(Uri.parse('$ip/login.php'), body: {
        "password": _passwordController.text,
        "email": _emailController.text
      });
      ModelLogin data = modelLoginFromJson(res.body);
      //cek kondisi (ini berdasarkan value respon api
      //value ,1 (ada data login),dan 0 (gagal)
      if (data.value == 1) {
        setState(() {
          //save session
          session.saveSession(
            data.value ?? 0,
            data.id ?? "",
            data.username ?? "",
            data.email ?? "",
          );

          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));

          //pindah ke page berita
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NavBar(),
            ),
            (route) => false,
          );
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
      }
    } catch (e) {
      //munculkan error
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 60),
              // Menggunakan Align untuk memposisikan secara horizontal di tengah
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'gambar/logo.png',
                ),
              ),
              SizedBox(height: 15),
              Text(
                'WELCOME',
                style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 5,),
              Text(
                'Login with your data entered while sign up',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: 'Enter your email or phone number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  prefixIcon: Icon(Icons.lock_outline),
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
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    loginAccount();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 120),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Text(
                      'SIGN UP',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
