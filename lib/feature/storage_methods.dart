import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageMethodsProvider = Provider(
    (ref) => StorageMethods(firebaseStorage: FirebaseStorage.instance));

class StorageMethods {
  final FirebaseStorage firebaseStorage;

  StorageMethods({required this.firebaseStorage});
  // storing image to the database firebase storage
  Future<String> uploadImageToStorage(String childName, File file) async {
    // Reference ref =
    //     firebaseStorage.ref().child(childName).child(_auth.currentUser!.uid);
    //  ref.putFile(file)  for data for web
    // UploadTask uploadTask = ref.putData(file);
    UploadTask uploadTask =
        firebaseStorage.ref().child(childName).putFile(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
