import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChapterModel {
  String uid;
  String url;
  DateTime at;

  ChapterModel({
    this.uid,
    this.url,
    this.at,
  });

  ChapterModel.fromDocumentSnapshot(
      {@required DocumentSnapshot documentSnapshot}) {
    uid = documentSnapshot.id;
    at = DateTime.parse(documentSnapshot.data()['at'].toDate().toString());
    url = documentSnapshot.data()['url'];
  }
}
