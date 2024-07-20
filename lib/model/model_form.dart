// To parse this JSON data, do
//
//     final modelForm = modelFormFromJson(jsonString);

import 'dart:convert';

ModelForm modelFormFromJson(String str) => ModelForm.fromJson(json.decode(str));

String modelFormToJson(ModelForm data) => json.encode(data.toJson());

class ModelForm {
    bool isSuccess;
    List<Datum> data;

    ModelForm({
        required this.isSuccess,
        required this.data,
    });

    factory ModelForm.fromJson(Map<String, dynamic> json) => ModelForm(
        isSuccess: json["isSuccess"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
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

    Datum({
        required this.id,
        required this.namaLengkap,
        required this.tempatTglLahir,
        required this.alamat,
        required this.cv,
        required this.other,
        required this.idUser,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        namaLengkap: json["nama_lengkap"],
        tempatTglLahir: json["tempat/tgl_lahir"],
        alamat: json["alamat"],
        cv: json["cv"],
        other: json["other"],
        idUser: json["id_user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_lengkap": namaLengkap,
        "tempat/tgl_lahir": tempatTglLahir,
        "alamat": alamat,
        "cv": cv,
        "other": other,
        "id_user": idUser,
    };
}
