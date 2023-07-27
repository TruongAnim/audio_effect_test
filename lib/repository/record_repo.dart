import 'dart:io';

import 'package:audio_effect_test/models/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RecordRepo {
  static final RecordRepo _instance = RecordRepo._();
  static RecordRepo get instance => _instance;
  RecordRepo._();

  Future<String> _uploadAudio(String id, String audioPath) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(File(audioPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> uploadRecord(Record record) async {
    DocumentReference recordRef =
        FirebaseFirestore.instance.collection('records').doc();
    record.audio = await _uploadAudio(recordRef.id, record.audio);
    await recordRef.set(record.toJson());
  }
}
