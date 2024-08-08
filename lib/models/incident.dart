import 'dart:io';

class Incident {
  final String title;
  final String date;
  final String description;
  final File? photo;
  final File? audio;

  Incident({
    required this.title,
    required this.date,
    required this.description,
    this.photo,
    this.audio,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'description': description,
      'photo': photo?.path,
      'audio': audio?.path,
    };
  }

  factory Incident.fromMap(Map<String, dynamic> map) {
    return Incident(
      title: map['title'],
      date: map['date'],
      description: map['description'],
      photo: map['photo'] != null ? File(map['photo']) : null,
      audio: map['audio'] != null ? File(map['audio']) : null,
    );
  }
}
