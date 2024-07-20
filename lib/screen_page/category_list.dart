import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projekuas/model/model_job.dart';
import 'package:projekuas/screen_page/detail_job.dart';
import 'package:http/http.dart' as http;
import 'package:projekuas/screen_page/job_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryJobsScreen extends StatefulWidget {
  final String category;

  CategoryJobsScreen({required this.category});

  @override
  _CategoryJobsScreenState createState() => _CategoryJobsScreenState();
}

class _CategoryJobsScreenState extends State<CategoryJobsScreen> {
  late Future<List<Datum>> jobs;
  List<Datum> allJobs = [];
  List<Datum> filteredJobs = [];
  List<Datum> bookmarkedJobs = [];
  String? id, username;

Future getSession() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  setState(() {
    id = pref.getString("id") ?? '';  // Ensure id is not null
    username = pref.getString("username") ?? '';  // Ensure username is not null
  });
}
  @override
  void initState() {
    super.initState();
    jobs = fetchJobsByCategory(widget.category);
    jobs.then((jobList) {
      setState(() {
        allJobs = jobList;
        filteredJobs = jobList;
      });
    });
  }

  Future<List<Datum>> fetchJobsByCategory(String category) async {
    final response = await http.get(Uri.parse('http://localhost/jobfinder/get_category_job.php'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['isSuccess']) {
        List jsonData = jsonResponse['data'];
        return jsonData.map((job) => Datum.fromJson(job)).toList();
      } else {
        throw Exception('Failed to load jobs');
      }
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  void toggleBookmark(Datum job) {
    setState(() {
      if (bookmarkedJobs.contains(job)) {
        bookmarkedJobs.remove(job);
      } else {
        bookmarkedJobs.add(job);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs in ${widget.category}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<List<Datum>>(
                future: jobs,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: filteredJobs.length,
                      itemBuilder: (context, index) {
                        return JobCard(
                          job: filteredJobs[index],
                          isBookmarked: bookmarkedJobs.contains(filteredJobs[index]),
                          onBookmarkToggle: toggleBookmark,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
