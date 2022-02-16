import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Use this for read and write operations to firebase
class StorageApi {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  StorageApi(
      {FirebaseFirestore? firebaseFirestore, FirebaseStorage? firebaseStorage})
      : firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  uploadImageToFirebaseStorage(Uint8List file, String fileName) {
    firebaseStorage.ref().child("files/$fileName").putData(file);
  }

  writeDataToCloudFireStore(Map<String, dynamic> map) {
    firebaseFirestore.collection('isues').doc().set(map);
  }
}
