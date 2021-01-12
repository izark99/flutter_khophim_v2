import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AccountModel {
  String uid;
  DateTime createAt;
  String email;
  String type;
  List likeList;

  AccountModel({
    this.uid,
    this.createAt,
    this.email,
    this.likeList,
    this.type,
  });

  AccountModel.fromDocumentSnapshot(
      {@required DocumentSnapshot documentSnapshot}) {
    uid = documentSnapshot.id;
    createAt =
        DateTime.parse(documentSnapshot.data()['createAt'].toDate().toString());
    email = documentSnapshot.data()['email'];
    type = documentSnapshot.data()['type'];
    likeList = documentSnapshot.data()['likeList'];
  }
}
