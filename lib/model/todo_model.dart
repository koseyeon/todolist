import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  final String description;
  final String author;
  final bool isDone;
  final String createdAt;

  TodoModel(
      {required this.description,
      required this.author,
      required this.isDone,
      required this.createdAt});
  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
}
