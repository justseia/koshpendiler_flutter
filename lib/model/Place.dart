// ignore_for_file: public_member_api_docs, sort_constructors_first
class Place {
  int id;
  String image;
  String name;
  String location_short;
  String body;
  String duration;
  String distance;
  String level;
  String cost;
  String to_destination;
  String with_you;
  String location;
  String created_at;
  Place({
    required this.id,
    required this.image,
    required this.name,
    required this.location_short,
    required this.body,
    required this.duration,
    required this.distance,
    required this.level,
    required this.cost,
    required this.to_destination,
    required this.with_you,
    required this.location,
    required this.created_at,
  });

  @override
  String toString() {
    return 'Place(id: $id, image: $image, name: $name, '
        'location_short: $location_short, body: $body, '
        'duration: $duration, distance: $distance, level: $level, '
        'cost: $cost, to_destination: $to_destination, '
        'with_you: $with_you, location: $location, created_at: $created_at)';
  }
}
