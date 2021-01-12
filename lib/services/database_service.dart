import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khophim/models/account_model.dart';

class DatabaseService {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  Future<String> createAccount({
    @required String uid,
    @required String email,
  }) async {
    try {
      await _database.collection("accounts").doc(uid).set({
        "email": email,
        "createAt": Timestamp.fromDate(DateTime.now()),
        "type": "User",
      });
      return "Success";
    } catch (e) {
      rethrow;
    }
  }

  Future<AccountModel> getAccountInfo({@required String uid}) async {
    DocumentSnapshot _doc =
        await _database.collection("accounts").doc(uid).get();
    return AccountModel.fromDocumentSnapshot(documentSnapshot: _doc);
  }
}
