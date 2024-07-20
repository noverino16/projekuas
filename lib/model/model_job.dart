// To parse this JSON data, do
//
//     final modelJob = modelJobFromJson(jsonString);

import 'dart:convert';

ModelJob modelJobFromJson(String str) => ModelJob.fromJson(json.decode(str));

String modelJobToJson(ModelJob data) => json.encode(data.toJson());

class ModelJob {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelJob({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelJob.fromJson(Map<String, dynamic> json) => ModelJob(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String namaJob;
    String salary;
    String companyName;
    String syarat;
    String tentangPekerjaan;
    String lokasi;
    String jobType;

    Datum({
        required this.id,
        required this.namaJob,
        required this.salary,
        required this.companyName,
        required this.syarat,
        required this.tentangPekerjaan,
        required this.lokasi,
        required this.jobType,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        namaJob: json["nama_job"],
        salary: json["salary"],
        companyName: json["company_name"],
        syarat: json["syarat"],
        tentangPekerjaan: json["tentang_pekerjaan"],
        lokasi: json["lokasi"],
        jobType: json["job_type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_job": namaJob,
        "salary": salary,
        "company_name": companyName,
        "syarat": syarat,
        "tentang_pekerjaan": tentangPekerjaan,
        "lokasi": lokasi,
        "job_type": jobType,
    };
}
