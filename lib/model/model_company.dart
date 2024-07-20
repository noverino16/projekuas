// To parse this JSON data, do
//
//     final modelCompany = modelCompanyFromJson(jsonString);

import 'dart:convert';

ModelCompany modelCompanyFromJson(String str) => ModelCompany.fromJson(json.decode(str));

String modelCompanyToJson(ModelCompany data) => json.encode(data.toJson());

class ModelCompany {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelCompany({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelCompany.fromJson(Map<String, dynamic> json) => ModelCompany(
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
    String namaPersusahaan;
    String email;
    String lokasi;

    Datum({
        required this.id,
        required this.namaPersusahaan,
        required this.email,
        required this.lokasi,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        namaPersusahaan: json["nama_persusahaan"],
        email: json["email"],
        lokasi: json["lokasi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_persusahaan": namaPersusahaan,
        "email": email,
        "lokasi": lokasi,
    };
}
