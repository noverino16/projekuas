import 'package:flutter/material.dart';

class DetailFormPage extends StatelessWidget {
  final Map<String, dynamic> form;

  const DetailFormPage({Key? key, required this.form}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Form'),
        backgroundColor: Color(0xFF88B0F4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Lengkap: ${form['nama_lengkap']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Alamat: ${form['alamat']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Job: ${form['nama_job']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Company: ${form['company_name']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Location: ${form['lokasi']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Syarat: ${form['syarat']}', style: TextStyle(fontSize: 16)),
            Text('Status: ${form['status']}',style:TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
