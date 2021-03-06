import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MovieModel {
  String uid;
  String name;
  String url;
  String img;
  DateTime at;

  MovieModel({
    this.uid,
    this.name,
    this.url,
    this.img,
    this.at,
  });

  MovieModel.fromDocumentSnapshot(
      {@required DocumentSnapshot documentSnapshot}) {
    uid = documentSnapshot.id;
    at = DateTime.parse(documentSnapshot.data()['at'].toDate().toString());
    name = documentSnapshot.data()['name'];
    url = documentSnapshot.data()['url'];
    img = documentSnapshot.data()['img'];
  }
}
