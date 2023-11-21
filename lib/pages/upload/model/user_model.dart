class Users {
  String id, dpUrl;
  final String firstName, lastName, userName, email, twitter, bio;
  final int phone, whatsApp;

  Users({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phone,
    required this.whatsApp,
    required this.twitter,
    required this.bio,
    this.dpUrl = '',
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
      'dpUrl': dpUrl,
    };
  }

  // Static method to create a User object from a Map
  static Users fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? 0,
      whatsApp: json['whatsApp'] ?? 0,
      twitter: json['twitter'] ?? '',
      bio: json['bio'] ?? '',
      dpUrl: json['dpUrl'] ?? '',
    );
  }
}
