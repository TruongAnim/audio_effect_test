import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  String id;
  String idSong;
  String name;
  String audio;
  double volumeSong;
  double volumeRecord;
  Record({
    required this.id,
    required this.idSong,
    required this.name,
    required this.audio,
    required this.volumeSong,
    required this.volumeRecord,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idSong': idSong,
      'name': name,
      'audio': audio,
      'volumeSong': volumeSong,
      'volumeRecord': volumeRecord,
    };
  }

  factory Record.fromMap(Map<String, dynamic> map) {
    return Record(
      id: map['id'] as String,
      idSong: map['idSong'] as String,
      name: map['name'] as String,
      audio: map['audio'] as String,
      volumeSong: map['volumeSong'] as double,
      volumeRecord: map['volumeRecord'] as double,
    );
  }

  factory Record.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;
    return Record(
      id: map['id'] as String,
      idSong: map['idSong'] as String,
      name: map['name'] as String,
      audio: map['audio'] as String,
      volumeSong: map['volumeSong'] as double,
      volumeRecord: map['volumeRecord'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Record.fromJson(String source) =>
      Record.fromMap(json.decode(source) as Map<String, dynamic>);
}
