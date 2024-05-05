// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class MenusModel {
  String? menuID;
  String? sellerUID;
  String? menuTitle;
  String? menuInfo;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? status;
  MenusModel({
    this.menuID,
    this.sellerUID,
    this.menuTitle,
    this.menuInfo,
    this.publishedDate,
    this.thumbnailUrl,
    this.status,
  });

  MenusModel.fromJson(Map<String, dynamic> json) {
    menuID = json['menuID'];
    sellerUID = json['sellerUID'];
    menuTitle = json['menuTitle'];
    menuInfo = json['menuInfo'];
    publishedDate = json['publishedDate'];
    status = json['status]'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}
