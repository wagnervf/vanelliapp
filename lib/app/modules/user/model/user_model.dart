import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserModel {
  late String? uid;
  late String? displayName;
  late String? email;

  late bool? emailVerified;
  late bool? isAnonymous;
  late String? photoURL;
  late String? providerId;

  UserModel({
    this.uid,
    this.displayName,
    this.emailVerified,
    this.isAnonymous,
    this.photoURL,
    this.providerId,
    this.email,
  });

  UserModel.fromDocumentCreate({doc, name}) {
    uid = doc.uid ?? Timestamp.now().millisecondsSinceEpoch;
    displayName = doc.displayName ?? name;
    email = doc.email ?? '';
    emailVerified = doc.emailVerified ?? false;
    isAnonymous = doc.isAnonymous ?? false;
    photoURL = doc.photoURL ?? '';
    providerId = doc.providerData[0].providerId ?? '';
  }

  UserModel.fromDocumentSnapshot(doc) {
    uid = doc["uid"];
    displayName = doc["displayName"] ?? "";
    email = doc["email"] ?? '';
    emailVerified = doc["emailVerified"] ?? false;
    isAnonymous = doc["isAnonymous"] ?? false;
    photoURL = doc["photoURL"] ?? '';
    providerId = doc["providerId"] ?? '';
  }

  UserModel.fromDocumentSnapshotGoogle(GoogleSignInAccount doc) {
    uid = doc.id;
    displayName = doc.displayName ?? '';
    email = doc.email;
    emailVerified = true;
    isAnonymous = false;
    photoURL = doc.photoUrl ?? '';
    providerId = "google";
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, displayName: $displayName, emailVerified: $emailVerified, isAnonymous: $isAnonymous, photoURL: $photoURL,  email: $email)';
  }
}
