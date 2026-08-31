
class Users {
  String id;
  String? name;
  String? email;
  String? about;
  String? image;
  bool? isOnline;
  String? lastActive;
 // Timestamp? createdAt;
  String? pushToken;

  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.about,
    required this.image,
    required this.isOnline,
    required this.lastActive,
    required this.pushToken,
    //this.createdAt,
  });

  // Convert from JSON (Firebase se data lene ke liye)
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      about: json['about'] ?? '',
      image: json['image'] ?? '',
      isOnline: json['isOnline'] is bool ? json['isOnline'] as bool : null,
      lastActive: json['lastActive'] ?? '',
      pushToken: json['pushToken'] ?? '',
      //createdAt: json['createdAt'] is Timestamp ? json['createdAt'] as Timestamp : null,
    );
  }

  // Convert to JSON (Firebase ya kisi bhi backend me save karne ke liye)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'about': about,
      'image': image,
      'isOnline': isOnline,
      'lastActive': lastActive,
      'pushToken': pushToken,
      //'createdAt': createdAt,
    };
  }
}
