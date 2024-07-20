import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projekuas/model/model_job.dart';
import 'package:projekuas/model/model_category.dart';
import 'package:projekuas/screen_page/detail_job.dart';
import 'package:projekuas/screen_page/job_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Datum>> jobs;
  late Future<List<Category>> categories;
  List<Datum> allJobs = [];
  List<Datum> filteredJobs = [];
  List<Datum> bookmarkedJobs = [];
  String? email;

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      email = pref.getString("username");
    });
  }

  @override
  void initState() {
    super.initState();
    getSession();
    jobs = fetchJobs();
    categories = fetchCategories();
    jobs.then((jobList) {
      setState(() {
        allJobs = jobList;
        filteredJobs = jobList;
      });
    });
  }

  Future<List<Datum>> fetchJobs() async {
    final response =
        await http.get(Uri.parse('http://localhost/jobfinder/get_job.php'));

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

  Future<List<Category>> fetchCategories() async {
    final response = await http
        .get(Uri.parse('http://localhost/jobfinder/get_category.php'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['isSuccess']) {
        List jsonData = jsonResponse['data'];
        return jsonData.map((category) => Category.fromJson(category)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }

  void filterJobs(String query) {
    setState(() {
      filteredJobs = allJobs
          .where((job) =>
              job.namaJob.toLowerCase().contains(query.toLowerCase()) ||
              job.companyName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset('gambar/profile.png'),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: [
                          Text(
                            "Hello,",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "$email,",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  TextField(
                    onChanged: (value) => filterJobs(value),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search Job or Company',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Browse By Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            FutureBuilder<List<Category>>(
              future: categories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: snapshot.data!.map((category) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    JobListScreen(category: category.kategori),
                              ),
                            );
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CategoryIcon(
                                icon: Icons.category, label: category.kategori),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              'Recommended work',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredJobs.length,
                itemBuilder: (context, index) {
                  return JobCard(
                    job: filteredJobs[index],
                    isBookmarked: bookmarkedJobs.contains(filteredJobs[index]),
                    onBookmarkToggle: toggleBookmark,
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Datum job;
  final bool isBookmarked;
  final Function(Datum) onBookmarkToggle;

  const JobCard(
      {Key? key,
      required this.job,
      required this.isBookmarked,
      required this.onBookmarkToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(job.namaJob),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.companyName),
            Text(job.salary),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
          ),
          onPressed: () => onBookmarkToggle(job),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailJobScreen(job: job),
            ),
          );
        },
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryIcon({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          child: Icon(icon, size: 20),
          radius: 25,
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
