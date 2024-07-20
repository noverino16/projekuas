import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projekuas/model/model_bookmark.dart';
// import 'package:projekuas/model/model_job.dart';
import 'package:projekuas/screen_page/detail_job.dart';
import 'package:projekuas/url/ip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkedJobsScreen extends StatefulWidget {
  // final int userId;
  const BookmarkedJobsScreen({Key? key}) : super(key: key);
  // const BookmarkedJobsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _BookmarkedJobsScreenState createState() => _BookmarkedJobsScreenState();
}

class _BookmarkedJobsScreenState extends State<BookmarkedJobsScreen> {
  String? id, username;
  bool isLoading = false;
  final List<Datum> _allBookmark = [];

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
    getSession().then((_) => getBookmark());
  }

  Future<void> getBookmark() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(Uri.parse('$ip/get_bookmark.php'), body: {
        "id_user": id,
      });
      if (response.statusCode == 200) {
        ModelBookmark data = modelBookmarkFromJson(response.body);
        setState(() {
          _allBookmark.clear();
          _allBookmark.addAll(data.data);
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load bookmark data");
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarked Jobs'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _allBookmark.isEmpty
              ? Center(child: Text('No bookmarked jobs'))
              : ListView.builder(
                  itemCount: _allBookmark.length,
                  itemBuilder: (context, index) {
                    return JobCard(
                      job: _allBookmark[index],
                      isBookmarked: true, // Since these are all bookmarked
                      onBookmarkToggle: (job) {
                        // Optional: Implement if you want to allow unbookmarking from here
                      },
                    );
                  },
                ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Datum job;
  final bool isBookmarked;
  final Function(Datum) onBookmarkToggle;

  const JobCard({Key? key, required this.job, required this.isBookmarked, required this.onBookmarkToggle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(job.namaJob),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.namaPersusahaan),
            Text(job.salary),
          ],
        ),
        // trailing: IconButton(
        //   icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
        //   onPressed: () => onBookmarkToggle(job),
        // ),
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DetailJobScreen(job:job),
          //   ),
          // );
          // Navigate to job detail screen if needed
        },
      ),
    );
  }
}
