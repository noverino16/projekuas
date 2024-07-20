// To parse this JSON data, do
//
//     final modelCategoryJob = modelCategoryJobFromJson(jsonString);

import 'dart:convert';

ModelCategoryJob modelCategoryJobFromJson(String str) => ModelCategoryJob.fromJson(json.decode(str));

String modelCategoryJobToJson(ModelCategoryJob data) => json.encode(data.toJson());

class ModelCategoryJob {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelCategoryJob({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelCategoryJob.fromJson(Map<String, dynamic> json) => ModelCategoryJob(
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
    String idPerusahaan;
    String idKategori;
    String jobType;
    String salary;
    String tentangPekerjaan;
    String syarat;
    String companyName;
    String lokasi;

    Datum({
        required this.id,
        required this.namaJob,
        required this.idPerusahaan,
        required this.idKategori,
        required this.jobType,
        required this.salary,
        required this.tentangPekerjaan,
        required this.syarat,
        required this.companyName,
        required this.lokasi,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        namaJob: json["nama_job"],
        idPerusahaan: json["id_perusahaan"],
        idKategori: json["id_kategori"],
        jobType: json["job_type"],
        salary: json["salary"],
        tentangPekerjaan: json["tentang_pekerjaan"],
        syarat: json["syarat"],
        companyName: json["company_name"],
        lokasi: json["lokasi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_job": namaJob,
        "id_perusahaan": idPerusahaan,
        "id_kategori": idKategori,
        "job_type": jobType,
        "salary": salary,
        "tentang_pekerjaan": tentangPekerjaan,
        "syarat": syarat,
        "company_name": companyName,
        "lokasi": lokasi,
    };
}
