// ignore_for_file: public_member_api_docs, sort_constructors_first
class LetterTileModel {
  int avtorId;
  String? text;
  DateTime time;
  String? urlToImage;
  bool isFromStorage;
  bool? isCouldnotSend;
  LetterTileModel({
    required this.avtorId,
    this.text,
    required this.time,
    this.urlToImage,
    required this.isFromStorage,
    this.isCouldnotSend,
  });

  @override
  String toString() {
    return 'LetterTileModel(avtorId: $avtorId, '
        'text: $text, '
        'time: $time, '
        'urlToImage: $urlToImage, '
        'isFromStorage: $isFromStorage'
        'isCouldnotSend: $isCouldnotSend'
        ')';
  }
}
