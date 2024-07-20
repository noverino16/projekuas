import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projekuas/model/model_job.dart' as jobModel;
import 'package:projekuas/model/model_company.dart' as companyModel;
import 'package:projekuas/screen_page/detail_job.dart';
import 'package:projekuas/url/ip.dart';

class DetailCompanyScreen extends StatefulWidget {
  final companyModel.Datum company;

  const DetailCompanyScreen({Key? key, required this.company}) : super(key: key);

  @override
  _DetailCompanyScreenState createState() => _DetailCompanyScreenState();
}

class _DetailCompanyScreenState extends State<DetailCompanyScreen> {
  late Future<List<jobModel.Datum>> jobs;
  List<jobModel.Datum> allJobs = [];
  List<jobModel.Datum> filteredJobs = [];
  List<jobModel.Datum> bookmarkedJobs = [];

  @override
  void initState() {
    super.initState();
    // Ensure company.id is an int before passing it to fetchJobs
    int companyId = int.tryParse(widget.company.id.toString()) ?? 0;
    jobs = fetchJobs(companyId);
    jobs.then((jobList) {
      setState(() {
        allJobs = jobList;
        filteredJobs = jobList;
      });
    });
  }

  Future<List<jobModel.Datum>> fetchJobs(int companyId) async {
    final response = await http.post(
      Uri.parse('$ip/get_company_job.php'),
      body: {
        "id_perusahaan": companyId.toString(),
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['isSuccess']) {
        List jsonData = jsonResponse['data'];
        return jsonData.map<jobModel.Datum>((job) => jobModel.Datum.fromJson(job)).toList();
      } else {
        throw Exception('Failed to load jobs');
      }
    } else {
      throw Exception('Failed to load jobs');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company.namaPersusahaan),
      ),
      body: FutureBuilder<List<jobModel.Datum>>(
        future: jobs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No jobs found.'));
          } else {
            return ListView.builder(
              itemCount: filteredJobs.length,
              itemBuilder: (context, index) {
                return JobCard(
                  job: filteredJobs[index],
                  // isBookmarked: bookmarkedJobs.contains(filteredJobs[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final jobModel.Datum job;
  // final bool isBookmarked;

  const JobCard({
    Key? key,
    required this.job,
    // required this.isBookmarked,
  }) : super(key: key);

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
        // trailing: IconButton(
        //   icon: Icon(
        //     isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        //   ),
        //   onPressed: () {},
        // ),
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
