import 'dart:convert';

import 'package:floor/floor.dart';

@entity
class Note {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String title;
  final String description;
  final String priority;
  final bool completed;
  String createdAt;

  Note({
    this.id,
    this.title = '',
    this.description = '',
    this.priority = 'Low',
    this.completed = false,
    this.createdAt = '',
  }) {
    if (this.createdAt.isEmpty) {
      this.createdAt = DateTime.now().toString();
    }
  }

  Note copyWith({
    int id,
    String title,
    String description,
    String priority,
    bool completed,
    String createdAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'completed': completed,
      'createdAt': createdAt,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
      completed: map['completed'],
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));
}
