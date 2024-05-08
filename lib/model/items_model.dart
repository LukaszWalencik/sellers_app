// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsModel {
  String? itemID;
  String? menuID;
  String? sellerUID;
  String? itemInfo;
  String? itemTitle;
  String? description;
  int? price;
  Timestamp? publishedDate;
  String? status;
  String? thumbnailUrl;
  ItemsModel({
    this.itemID,
    this.menuID,
    this.sellerUID,
    this.itemInfo,
    this.itemTitle,
    this.description,
    this.price,
    this.publishedDate,
    this.status,
    this.thumbnailUrl,
  });
}
