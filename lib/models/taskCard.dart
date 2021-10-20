import 'package:todo/main.dart';

class TaskCard {
  final int id;
  final String title;
  final String description;

  TaskCard(this.id, this.title, this.description);

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

}