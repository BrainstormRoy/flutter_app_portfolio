class User {
  String id;
  final String firstName, lastName, userName, email, twitter, bio;
  final int phone, whatsApp;

  User({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phone,
    required this.whatsApp,
    required this.twitter,
    required this.bio,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'phone': phone,
      'whatsApp': whatsApp,
      'twitter': twitter,
      'bio': bio,
    };
  }

  // Static method to create a User object from a Map
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? 0,
      whatsApp: json['whatsApp'] ?? 0,
      twitter: json['twitter'] ?? '',
      bio: json['bio'] ?? '',
    );
  }
}
