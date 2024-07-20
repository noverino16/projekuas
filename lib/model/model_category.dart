// To parse this JSON data, do
//
//     final modelCategory = modelCategoryFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

ModelCategory modelCategoryFromJson(String str) => ModelCategory.fromJson(json.decode(str));

String modelCategoryToJson(ModelCategory data) => json.encode(data.toJson());

class ModelCategory {
    bool isSuccess;
    String message;
    List<Category> data;

    ModelCategory({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelCategory.fromJson(Map<String, dynamic> json) => ModelCategory(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Category {
    String id;
    String kategori;

    Category({
        required this.id,
        required this.kategori,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        kategori: json["kategori"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "kategori": kategori,
    };
}
