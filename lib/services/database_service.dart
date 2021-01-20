import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khophim/models/account_model.dart';
import 'package:khophim/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:khophim/models/temp_model.dart';

const String apiKey = "4d4e4032d83cc5687487d5da7fd41907";

class Client {
  String baseUrl = "https://api.themoviedb.org/3";
  Future<List<Results>> getTrending() async {
    String url = "$baseUrl/trending/all/day?api_key=$apiKey";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      MovieList temp = MovieList.fromJson(json.decode(response.body));
      List<Results> data = temp.results;
      return data;
    } else {
      return [];
    }
  }
}

class DatabaseService {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Stream<bool> streamStatus() {
    return _database
        .collection("status")
        .doc("statusApp")
        .snapshots()
        .map((event) => event.data()["ok"]);
  }

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
    url = url.replaceAll("/", ">");
    try {
      await _database
          .collection("accounts")
          .doc(uid)
          .collection("historyList")
          .doc(url)
          .set(
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
  }

  Stream<List<String>> streamHistoryNameList(
      {@required String uid, @required int limit}) {
    try {
      return _database
          .collection("accounts")
          .doc(uid)
          .collection("historyList")
          .orderBy("at", descending: true)
          .limit(limit)
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

  Stream<List<String>> streamHistoryImageList(
      {@required String uid, @required int limit}) {
    try {
      return _database
          .collection("accounts")
          .doc(uid)
          .collection("historyList")
          .orderBy("at", descending: true)
          .limit(limit)
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

  Future<int> getLengthHistoryList({@required String uid}) {
    try {
      return _database
          .collection("accounts")
          .doc(uid)
          .collection("historyList")
          .get()
          .then((value) => value.docs.length);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<String>> streamHistoryLinkList(
      {@required String uid, @required int limit}) {
    try {
      return _database
          .collection("accounts")
          .doc(uid)
          .collection("historyList")
          .orderBy("at", descending: true)
          .limit(limit)
          .snapshots()
          .map((movie) {
        final List<String> retVal = [];
        for (final DocumentSnapshot doc in movie.docs) {
          retVal.add(
            MovieModel.fromDocumentSnapshot(documentSnapshot: doc)
                .uid
                .replaceAll(">", "/"),
          );
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addChapter({
    @required String uid,
    @required String url,
    @required String urlChapter,
  }) async {
    url = url.replaceAll("/", ">");
    urlChapter = urlChapter.replaceAll("/", ">");
    try {
      await _database
          .collection("accounts")
          .doc(uid)
          .collection("historyList")
          .doc(url)
          .collection("chapterList")
          .doc(urlChapter)
          .set(
        {
          "at": DateTime.now(),
        },
      );
      return "Success";
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<String>> streamChapter(
      {@required String uid, @required String url}) {
    url = url.replaceAll("/", ">");
    try {
      return _database
          .collection("accounts")
          .doc(uid)
          .collection("historyList")
          .doc(url)
          .collection("chapterList")
          .orderBy("at", descending: true)
          .snapshots()
          .map((chapter) {
        final List<String> retVal = [];
        for (final DocumentSnapshot doc in chapter.docs) {
          retVal.add(
            MovieModel.fromDocumentSnapshot(documentSnapshot: doc)
                .uid
                .replaceAll(">", "/"),
          );
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<String> delHistoryMovie(
      {@required String uid, @required String url}) async {
    url = url.replaceAll("/", ">");
    try {
      await _database
          .collection("accounts")
          .doc(uid)
          .collection("historyList")
          .doc(url)
          .delete();
      return "Success";
    } catch (e) {
      rethrow;
    }
  }
}
