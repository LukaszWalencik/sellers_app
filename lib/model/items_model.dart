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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemID': itemID,
      'menuID': menuID,
      'sellerUID': sellerUID,
      'itemInfo': itemInfo,
      'itemTitle': itemTitle,
      'description': description,
      'price': price,
      'publishedDate': publishedDate,
      'status': status,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory ItemsModel.fromMap(Map<String, dynamic> map) {
    return ItemsModel(
      itemID: map['itemID'] != null ? map['itemID'] as String : null,
      menuID: map['menuID'] != null ? map['menuID'] as String : null,
      sellerUID: map['sellerUID'] != null ? map['sellerUID'] as String : null,
      itemInfo: map['itemInfo'] != null ? map['itemInfo'] as String : null,
      itemTitle: map['itemTitle'] != null ? map['itemTitle'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null ? map['price'] as int : null,
      publishedDate: map['publishedDate'] != null
          ? map['publishedDate'] as Timestamp
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      thumbnailUrl:
          map['thumbnailUrl'] != null ? map['thumbnailUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemsModel.fromJson(String source) =>
      ItemsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
