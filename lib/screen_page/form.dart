import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:projekuas/screen_page/detail_job.dart';
import 'package:projekuas/screen_page/setting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormPage extends StatefulWidget {
  final String idJob;

  const FormPage({Key? key, required this.idJob}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _tempatTanggalLahirController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  // final TextEditingController _idUserController = TextEditingController();

  Uint8List? _cvFileBytes;
  String? _cvFileName;
  Uint8List? _otherFileBytes;
  String? _otherFileName;
  String? id, username, email;

  @override
  void initState() {
    super.initState();
    getSession();
  }

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
      username = pref.getString("username");
      email = pref.getString("email");
    });
  }

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _tempatTanggalLahirController.dispose();
    _alamatController.dispose();
    // _idUserController.dispose();
    super.dispose();
  }

  Future<void> _pickFile(bool isCv) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          if (isCv) {
            _cvFileBytes = result.files.first.bytes;
            _cvFileName = result.files.first.name;
          } else {
            _otherFileBytes = result.files.first.bytes;
            _otherFileName = result.files.first.name;
          }
        });
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_namaLengkapController.text.isEmpty ||
        _tempatTanggalLahirController.text.isEmpty ||
        _alamatController.text.isEmpty ||
        id == null ||
        _cvFileBytes == null ||
        _otherFileBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all the fields and upload all files')),
      );
      return;
    }

    final uri = Uri.parse('http://localhost/jobfinder/add_form.php');
    final request = http.MultipartRequest('POST', uri)
      ..fields['nama_lengkap'] = _namaLengkapController.text
      ..fields['tempat_tgl_lahir'] = _tempatTanggalLahirController.text
      ..fields['alamat'] = _alamatController.text
      ..fields['id_user'] = id! // Use the id from session
      ..fields['id_job'] = widget.idJob; // Pass the id_job here

    request.files.add(http.MultipartFile.fromBytes(
      'cv',
      _cvFileBytes!,
      filename: _cvFileName,
    ));
    request.files.add(http.MultipartFile.fromBytes(
      'other',
      _otherFileBytes!,
      filename: _otherFileName,
    ));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody');
        final jsonResponse = jsonDecode(responseBody);
        if (jsonResponse['isSuccess']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Form submitted successfully!')),
            
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to submit form: ${jsonResponse['message']}')),
          );
        }
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Failed to submit form: ${response.statusCode} - $responseBody');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit form.')),
        );
      }
    } catch (e) {
      print('Error submitting form: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting form: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF88B0F4),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Form', style: TextStyle()),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(Icons.list, size: 50),
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFF88B0F4),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _namaLengkapController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _tempatTanggalLahirController,
              decoration: InputDecoration(
                labelText: 'Tempat/Tanggal Lahir',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _alamatController,
              decoration: InputDecoration(
                labelText: 'Alamat',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintMaxLines: 3,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              readOnly: true,
              controller: TextEditingController(
                text: _cvFileName ?? '',
              ),
              decoration: InputDecoration(
                labelText: 'CV',
                suffixIcon: IconButton(
                  icon: Icon(Icons.upload_file),
                  onPressed: () => _pickFile(true),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              readOnly: true,
              controller: TextEditingController(
                text: _otherFileName ?? '',
              ),
              decoration: InputDecoration(
                labelText: 'Other Dokumen',
                suffixIcon: IconButton(
                  icon: Icon(Icons.upload_file),
                  onPressed: () => _pickFile(false),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                textStyle: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
