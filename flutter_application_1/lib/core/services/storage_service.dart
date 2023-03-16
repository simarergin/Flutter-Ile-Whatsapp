import 'dart:io';
import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<Reference> uploadFile(file) async {
    var uploadTask = _firebaseStorage
        .ref()
        .child(
            "${DateTime.now().millisecondsSinceEpoch.toString()}.${file.relativePath?.split('.').last}")
        .putFile(file);

    uploadTask.snapshotEvents.listen((event) {
      print(event);
    });

    // var storageRef = uploadTask.whenComplete(() => null);

    var snapShot = await uploadTask;
    return snapShot.ref;
  }
}
