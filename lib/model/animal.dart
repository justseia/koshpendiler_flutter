// ignore_for_file: public_member_api_docs, sort_constructors_first
class Animal {
  int id;
  String name;
  List<String> images;
  String created_at;
  Animal({
    required this.id,
    required this.name,
    required this.images,
    required this.created_at,
  });

  @override
  String toString() {
    return 'Animal(id: $id, name: $name, images: $images, created_at: $created_at)';
  }
}
