import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khophim/models/account_model.dart';
import 'package:khophim/models/movie_model.dart';

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

  Future<String> addToHistoryList({
    @required String uid,
    @required String url,
    @required String name,
    @required String img,
  }) async {
    List<QueryDocumentSnapshot> temp = await _database
        .collection("accounts")
        .doc(uid)
        .collection("historyList")
        .where("url", isEqualTo: url)
        .get()
        .then((v) => v.docs);
    int result = temp.length;
    if (result > 0) {
      try {
        await _database
            .collection("accounts")
            .doc(uid)
            .collection("historyList")
            .doc(temp[0].id)
            .update(
          {
            "at": DateTime.now(),
            "img": img,
            "name": name,
          },
        );
        return "Success";
      } catch (e) {
        rethrow;
      }
    } else {
      try {
        await _database
            .collection("accounts")
            .doc(uid)
            .collection("historyList")
            .add(
          {
            "url": url,
            "img": img,
            "name": name,
            "at": DateTime.now(),
          },
        );
        return "Success";
      } catch (e) {
        rethrow;
      }
    }
  }

  Stream<List<String>> streamHistoryNameList({@required String uid}) {
    try {
      return _database
          .collection("accounts")
          .doc(uid)
          .collection("historyList")
          .orderBy("at", descending: true)
          .snapshots()
          .map((movie) {
        final List<String> retVal = [];
        for (final DocumentSnapshot doc in movie.docs) {
          retVal
              .add(MovieModel.fromDocumentSnapshot(documentSnapshot: doc).name);
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<String>> streamHistoryImageList({@required String uid}) {
    try {
      return _database
          .collection("accounts")
          .doc(uid)
          .collection("historyList")
          .orderBy("at", descending: true)
          .snapshots()
          .map((movie) {
        final List<String> retVal = [];
        for (final DocumentSnapshot doc in movie.docs) {
          retVal
              .add(MovieModel.fromDocumentSnapshot(documentSnapshot: doc).img);
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<String>> streamHistoryLinkList({@required String uid}) {
    try {
      return _database
          .collection("accounts")
          .doc(uid)
          .collection("historyList")
          .orderBy("at", descending: true)
          .snapshots()
          .map((movie) {
        final List<String> retVal = [];
        for (final DocumentSnapshot doc in movie.docs) {
          retVal
              .add(MovieModel.fromDocumentSnapshot(documentSnapshot: doc).url);
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }
}
