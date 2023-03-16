import 'dart:html';
import 'dart:io';
import 'base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/core/services/locator.dart';
import 'package:flutter_application_1/core/services/storage_service.dart';
import 'package:flutter_application_1/viewmodels/base_model.dart';
import 'package:image_picker/image_picker.dart';

class ConversationModel extends BaseModel {
  final StorageService _storageService = getIt<StorageService>();
  final ImagePicker _picker = ImagePicker();
  CollectionReference? _ref;
  String uploadMedia = '';

  Stream<QuerySnapshot<Object?>>? getConversation(String id) {
    _ref = FirebaseFirestore.instance.collection('conversations/$id/messages');

    return _ref?.orderBy('timeStamp').snapshots();
  }

  Future<void>? add(Map<String, dynamic> data) async {
    await _ref?.add(data);

    uploadMedia = '';
    notifyListeners();
  }
}
