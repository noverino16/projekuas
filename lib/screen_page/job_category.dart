import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:projekuas/model/model_job.dart';

class JobListScreen extends StatefulWidget {
  final String category;

  const JobListScreen({Key? key, required this.category}) : super(key: key);

  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  late Future<List<Datum>> jobs;

  @override
  void initState() {
    super.initState();
    jobs = fetchJobsByCategory(widget.category);
  }

  Future<List<Datum>> fetchJobsByCategory(String category) async {
    final response = await http.get(Uri.parse('http://localhost/jobfinder/get_category_job.php?category=$category'));

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['isSuccess']) {
        List<dynamic> jsonData = jsonResponse['data'];
        print('jsonData: $jsonData');
        jsonData.forEach((job) {
          print('Job: $job');
          print('Job ID: ${job['id']}');
          print('Job Name: ${job['nama_job']}');
        });
        return jsonData.map((job) => Datum.fromJson(job)).toList();
      } else {
        throw Exception('Failed to load jobs: ${jsonResponse['message']}');
      }
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs in ${widget.category}'),
      ),
      body: FutureBuilder<List<Datum>>(
        future: jobs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final job = snapshot.data![index];
                return ListTile(
                  title: Text(job.namaJob),
                  subtitle: Text(job.companyName),
                );
              },
            );
          } else {
            return Center(child: Text('No jobs found'));
          }
        },
      ),
    );
  }
}
