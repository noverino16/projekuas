// To parse this JSON data, do
//
//     final modelUserForm = modelUserFormFromJson(jsonString);

import 'dart:convert';

ModelUserForm modelUserFormFromJson(String str) => ModelUserForm.fromJson(json.decode(str));

String modelUserFormToJson(ModelUserForm data) => json.encode(data.toJson());

class ModelUserForm {
    bool isSuccess;
    List<Datum> forms;

    ModelUserForm({
        required this.isSuccess,
        required this.forms,
    });

    factory ModelUserForm.fromJson(Map<String, dynamic> json) => ModelUserForm(
        isSuccess: json["isSuccess"],
        forms: List<Datum>.from(json["forms"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "forms": List<dynamic>.from(forms.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String namaLengkap;
    String tempatTglLahir;
    String alamat;
    String cv;
    String other;
    String idUser;
    String idJob;
    String status;
    String namaJob;
    String idPerusahaan;
    String idKategori;
    String jobType;
    String salary;
    String tentangPekerjaan;
    String syarat;
    String lokasi;
    String namaPersusahaan;

    Datum({
        required this.id,
        required this.namaLengkap,
        required this.tempatTglLahir,
        required this.alamat,
        required this.cv,
        required this.other,
        required this.idUser,
        required this.idJob,
        required this.status,
        required this.namaJob,
        required this.idPerusahaan,
        required this.idKategori,
        required this.jobType,
        required this.salary,
        required this.tentangPekerjaan,
        required this.syarat,
        required this.lokasi,
        required this.namaPersusahaan,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        namaLengkap: json["nama_lengkap"],
        tempatTglLahir: json["tempat/tgl_lahir"],
        alamat: json["alamat"],
        cv: json["cv"],
        other: json["other"],
        idUser: json["id_user"],
        idJob: json["id_job"],
        status: json["status"],
        namaJob: json["nama_job"],
        idPerusahaan: json["id_perusahaan"],
        idKategori: json["id_kategori"],
        jobType: json["job_type"],
        salary: json["salary"],
        tentangPekerjaan: json["tentang_pekerjaan"],
        syarat: json["syarat"],
        lokasi: json["lokasi"],
        namaPersusahaan: json["nama_persusahaan"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_lengkap": namaLengkap,
        "tempat/tgl_lahir": tempatTglLahir,
        "alamat": alamat,
        "cv": cv,
        "other": other,
        "id_user": idUser,
        "id_job": idJob,
        "status": status,
        "nama_job": namaJob,
        "id_perusahaan": idPerusahaan,
        "id_kategori": idKategori,
        "job_type": jobType,
        "salary": salary,
        "tentang_pekerjaan": tentangPekerjaan,
        "syarat": syarat,
        "lokasi": lokasi,
        "nama_persusahaan": namaPersusahaan,
    };
}
