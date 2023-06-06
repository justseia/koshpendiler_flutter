// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileModel {
  int id;
  String? full_name;
  String? email;
  String? phone;
  String? gender;
  DateTime? birth;
  String? image;
  ProfileModel({
    required this.id,
    this.full_name,
    this.email,
    this.phone,
    this.gender,
    this.birth,
    this.image,
  });

  @override
  String toString() {
    return 'ProfileModel(id: $id, full_name: $full_name, email: $email, phone: $phone, gender: $gender, birth: $birth, image: $image)';
  }
}
