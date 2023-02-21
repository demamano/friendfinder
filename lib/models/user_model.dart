import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String photoUrl;
  // final String username;
  final String fullName;
  // final String email;
  final String interests;
  final bool isOnline;
  final List<String> groupId;
  // final String country;
  final String fieldOfStudy;
  UserModel(
      {
      // required this.email,
      required this.uid,
      required this.photoUrl,
      required this.groupId,
      required this.fullName,
      // required this.username,
      required this.isOnline,
      required this.interests,
      required this.fieldOfStudy});

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        // username: snapshot["username"],
        uid: snapshot["uid"],
        // email: snapshot["email"],
        photoUrl: snapshot["photoUrl"],
        fullName: snapshot["fullName"],
        groupId: [],
        isOnline: snapshot["isOnline"],
        interests: snapshot['interets'],
        fieldOfStudy: snapshot["fieldOfStudy"]);
  }

  UserModel copyWith({
    String? uid,
    String? fullName,
    String? username,
    String? photoUrl,
    String? email,
    String? lastMessage,
  }) =>
      UserModel(
          // email: email ?? "",
          uid: uid ?? '',
          photoUrl: photoUrl ?? '',
          fullName: fullName ?? '',
          // username: username ?? '',
          groupId: [],
          isOnline: isOnline,
          interests: interests,
          fieldOfStudy: fieldOfStudy,
          
          );

  // Map<String, dynamic> toJson() {
  //   return {
  //     'email': email,
  //     'uid': uid,
  //     'photoUrl': photoUrl,
  //     'username': username,
  //     'fullName': fullName,
  //     'groups': groupId
  //   };
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'photoUrl': photoUrl,
      // 'username': username,
      'fullName': fullName,
      'isOnline': isOnline,
      // 'email': email,
      'groupId': groupId,
      'interests': interests,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'] as String,
        photoUrl: map['photoUrl'] as String,
        fullName: map['fullName'] as String,
        isOnline: map['isOnline'] as bool,
        // email: map['email'] as String,
        fieldOfStudy: map['fieldOfStudy'] as String,
        groupId: List<String>.from(
          (map['groupId'] as List<String>),
        ),
        interests: map['interests'] as String);
  }
}
