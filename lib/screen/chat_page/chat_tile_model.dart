// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

class ChatTileModel {
  int fromId;
  String urlToImage;
  String name;
  String textLetter;
  String time;
  bool isPopular; // птичка есть или нет
  int unReadLetters;
  ChatTileModel({
    required this.fromId,
    required this.urlToImage,
    required this.name,
    required this.textLetter,
    required this.time,
    required this.isPopular,
    required this.unReadLetters,
  });

  @override
  String toString() {
    return 'ChatTileModel(fromId: $fromId, urlToImage: $urlToImage, name: $name, textLetter: $textLetter, time: $time, isClientTop: $isPopular, unReadLetters: $unReadLetters)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fromId': fromId,
      'urlToImage': urlToImage,
      'name': name,
      'textLetter': textLetter,
      'time': time,
      'isClientTop': isPopular,
      'unReadLetters': unReadLetters,
    };
  }

  factory ChatTileModel.fromMap(Map<String, dynamic> map) {
    return ChatTileModel(
      fromId: map['fromId'] as int,
      urlToImage: map['urlToImage'] as String,
      name: map['name'] as String,
      textLetter: map['textLetter'] as String,
      time: map['time'] as String,
      isPopular: map['isClientTop'] as bool,
      unReadLetters: map['unReadLetters'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatTileModel.fromJson(String source) =>
      ChatTileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ChatTileModel copyWith({
    int? fromId,
    String? urlToImage,
    String? name,
    String? textLetter,
    String? time,
    bool? isClientTop,
    int? unReadLetters,
  }) {
    return ChatTileModel(
      fromId: fromId ?? this.fromId,
      urlToImage: urlToImage ?? this.urlToImage,
      name: name ?? this.name,
      textLetter: textLetter ?? this.textLetter,
      time: time ?? this.time,
      isPopular: isClientTop ?? this.isPopular,
      unReadLetters: unReadLetters ?? this.unReadLetters,
    );
  }
}

class ChatTileModelAdapter extends TypeAdapter<ChatTileModel> {
  @override
  ChatTileModel read(BinaryReader reader) {
    // TODO: implement read
    final fromId = reader.readInt();
    final urlToImage = reader.readString();
    final name = reader.readString();
    final textLetter = reader.readString();
    final time = reader.readString();
    final isClientTop = reader.readBool();
    final unReadLetters = reader.readInt();
    return ChatTileModel(
      fromId: fromId,
      urlToImage: urlToImage,
      name: name,
      textLetter: textLetter,
      time: time,
      isPopular: isClientTop,
      unReadLetters: unReadLetters,
    );
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, ChatTileModel obj) {
    // TODO: implement write
    writer.writeInt(obj.fromId);
    writer.writeString(obj.urlToImage);
    writer.writeString(obj.name);
    writer.writeString(obj.textLetter);
    writer.writeString(obj.time);
    writer.writeBool(obj.isPopular);
    writer.writeInt(obj.unReadLetters);
  }

  // int fromId;
  // String urlToImage;
  // String name;
  // String textLetter;
  // String time;
  // bool isClientTop; // птичка есть или нет
  // int unReadLetters;
  // ChatTileModel({
  //   required this.fromId,
  //   required this.urlToImage,
  //   required this.name,
  //   required this.textLetter,
  //   required this.time,
  //   required this.isClientTop,
  //   required this.unReadLetters,
  // });
  // @override
  // String toString() {
  //   return 'ChatTileModel(fromId: $fromId, urlToImage: $urlToImage, name: $name, textLetter: $textLetter, time: $time, isClientTop: $isClientTop, unReadLetters: $unReadLetters)';
  // }
}
