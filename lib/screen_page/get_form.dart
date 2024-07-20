import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projekuas/url/ip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_form.dart';

class UserFormsPage extends StatefulWidget {
  @override
  _UserFormsPageState createState() => _UserFormsPageState();
}

class _UserFormsPageState extends State<UserFormsPage> {
  String? idUser;
  List<dynamic> forms = [];

  @override
  void initState() {
    super.initState();
    _getSessionAndFetchForms();
  }

  Future<void> _getSessionAndFetchForms() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idUser = pref.getString("id");
    });
    if (idUser != null) {
      _fetchForms(idUser!);
    }
  }

  Future<void> _fetchForms(String idUser) async {
    final uri = Uri.parse('http://localhost/jobfinder/get_form.php');
    try {
      final response = await http.post(uri, body: {'id_user': idUser});
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['isSuccess']) {
          setState(() {
            forms = jsonResponse['forms'];
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to fetch forms: ${jsonResponse['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch forms: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching forms: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Forms'),
        backgroundColor: Color(0xFF88B0F4),
      ),
      body: Container(
        color: Color(0xFF88B0F4),
        padding: const EdgeInsets.all(16.0),
        child: forms.isEmpty
            ? Center(child: Text('No forms found'))
            : ListView.builder(
                itemCount: forms.length,
                itemBuilder: (context, index) {
                  final form = forms[index];
                  return Card(
                    child: ListTile(
                      title: Text(form['nama_lengkap']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Alamat: ${form['alamat']}'),
                          Text('Job: ${form['nama_job']}'),
                          Text('Company: ${form['company_name']}'),
                          Text('Location: ${form['lokasi']}'),
                          Text('Status: ${form['status']}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          // Handle detail or other actions
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailFormPage(form: form),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
