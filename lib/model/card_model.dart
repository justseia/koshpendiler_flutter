// ignore_for_file: public_member_api_docs, sort_constructors_first
class CardModel {
  String user_id;
  String full_name;
  String number;
  String date;
  String cvc;
  CardModel({
    required this.user_id,
    required this.full_name,
    required this.number,
    required this.date,
    required this.cvc,
  });

  @override
  String toString() {
    return 'CardModel(user_id: $user_id, full_name: $full_name, number: $number, date: $date, cvc: $cvc)';
  }
}
