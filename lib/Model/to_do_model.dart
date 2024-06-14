class Item {
  String title;
  String description;
  DateTime uploadDateTime;
  bool isCompleted;

  Item({
    required this.title,
    required this.description,
    required this.uploadDateTime,
    this.isCompleted = false,
  });
}
class User {
  final int id;
  final String name;
  final String email;
  final String address;

  User({required this.id, required this.name, required this.email, required this.address});

  // Factory constructor to create a User from a JSON object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      address: json["address"]
    );
  }

  // Method to convert a User to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address':address
    };
  }
}