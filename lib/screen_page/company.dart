// import 'package:flutter/material.dart';
// import 'package:projekuas/model/model_company.dart';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:projekuas/screen_page/detail_company.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projekuas/model/model_job.dart' as jobModel;
import 'package:projekuas/model/model_company.dart' as companyModel;
import 'package:projekuas/screen_page/detail_company.dart';
import 'package:projekuas/url/ip.dart';


import 'package:flutter/material.dart';
import 'package:projekuas/model/model_company.dart' as companyModel;
// import 'package:projekuas/detail_company.dart';

class CompaniesScreen extends StatefulWidget {
  @override
  _CompaniesScreenState createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  late Future<List<companyModel.Datum>> companies;

  @override
  void initState() {
    super.initState();
    companies = fetchCompanies();
  }

  Future<List<companyModel.Datum>> fetchCompanies() async {
    final response = await http.get(Uri.parse('http://localhost/jobfinder/get_company.php'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['isSuccess']) {
        List jsonData = jsonResponse['data'];
        return jsonData.map((company) => companyModel.Datum.fromJson(company)).toList();
      } else {
        throw Exception('Failed to load companies');
      }
    } else {
      throw Exception('Failed to load companies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Companies'),
      ),
      body: FutureBuilder<List<companyModel.Datum>>(
        future: companies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CompanyCard(
                  company: snapshot.data![index],
                  isBookmarked: false, // Add your bookmark logic here
                  onBookmarkToggle: (company) {}, // Add your bookmark toggle logic here
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CompanyCard extends StatelessWidget {
  final companyModel.Datum company;
  final bool isBookmarked;
  final Function(companyModel.Datum) onBookmarkToggle;

  const CompanyCard({
    Key? key,
    required this.company,
    required this.isBookmarked,
    required this.onBookmarkToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(company.namaPersusahaan),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(company.lokasi),
            Text(company.email),
          ],
        ),
        //
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailCompanyScreen(company: company),
            ),
          );
        },
      ),
    );
  }
}
