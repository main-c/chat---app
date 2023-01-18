class User {
  final int id;
  final String name;
  final String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}

class Contact {
  final int id;
  final String username;
  final String imageUrl;

  Contact({
    required this.id,
    required this.username,
    required this.imageUrl,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: 1,
      username: json['login'],
      imageUrl: "https://picsum.photos/200",
    );
  }

  List<Contact> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Contact.fromJson(json)).toList();
  }
}
