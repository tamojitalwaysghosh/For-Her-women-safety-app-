import 'package:flutter/material.dart';

class Task {
  String content;
  DateTime timeStamp;
  bool done;

  Task({
    required this.content,
    required this.timeStamp,
    required this.done,
  });

  factory Task.fromMap(Map task) {
    return Task(
      content: task["content"],
      timeStamp: task["timeStamp"],
      done: task["done"],
    );
  }

  Map toMap() {
    return {
      "content": content,
      "timeStamp": timeStamp,
      "done": done,
    };
  }
}
