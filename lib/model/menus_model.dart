// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class MenusModel {
  String? menuID;
  String? sellerUID;
  String? menuTitle;
  String? menuInfo;
  Timestamp? publishedDate;
  String? thumbailUrl;
  String? status;
  MenusModel({
    this.menuID,
    this.sellerUID,
    this.menuTitle,
    this.menuInfo,
    this.publishedDate,
    this.thumbailUrl,
    this.status,
  });
}
