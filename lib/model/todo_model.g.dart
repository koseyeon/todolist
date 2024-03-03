// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => TodoModel(
      description: json['description'] as String,
      author: json['author'] as String,
      isDone: json['isDone'] as bool,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
      'description': instance.description,
      'author': instance.author,
      'isDone': instance.isDone,
      'createdAt': instance.createdAt,
    };
