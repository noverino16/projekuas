// To parse this JSON data, do
//
//     final modelBookmark = modelBookmarkFromJson(jsonString);

import 'dart:convert';

ModelBookmark modelBookmarkFromJson(String str) => ModelBookmark.fromJson(json.decode(str));

String modelBookmarkToJson(ModelBookmark data) => json.encode(data.toJson());

class ModelBookmark {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelBookmark({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelBookmark.fromJson(Map<String, dynamic> json) => ModelBookmark(
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
    String namaPersusahaan;
    String salary;
    String lokasi;
    String idPerusahaan;
    String idKategori;
    String jobType;
    String tentangPekerjaan;
    String syarat;

    Datum({
        required this.id,
        required this.namaJob,
        required this.namaPersusahaan,
        required this.salary,
        required this.lokasi,
        required this.idPerusahaan,
        required this.idKategori,
        required this.jobType,
        required this.tentangPekerjaan,
        required this.syarat,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        namaJob: json["nama_job"],
        namaPersusahaan: json["nama_persusahaan"],
        salary: json["salary"],
        lokasi: json["lokasi"],
        idPerusahaan: json["id_perusahaan"],
        idKategori: json["id_kategori"],
        jobType: json["job_type"],
        tentangPekerjaan: json["tentang_pekerjaan"],
        syarat: json["syarat"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_job": namaJob,
        "nama_persusahaan": namaPersusahaan,
        "salary": salary,
        "lokasi": lokasi,
        "id_perusahaan": idPerusahaan,
        "id_kategori": idKategori,
        "job_type": jobType,
        "tentang_pekerjaan": tentangPekerjaan,
        "syarat": syarat,
    };
}
