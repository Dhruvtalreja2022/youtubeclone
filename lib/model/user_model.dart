import 'dart:convert';

class UserModel {
  final String displayName;
  final String userName;
  final String email;
  final String profilePic;
  List<String> subscription;
  final int videos;
  final String userId;
  final String description;
  final String type;

  UserModel({
    required this.displayName,
    required this.userName,
    required this.email,
    required this.profilePic,
    required this.subscription,
    required this.videos,
    required this.userId,
    required this.description,
    required this.type,
  });

  // Secondary constructor with only required fields
  UserModel.minimal({
    required this.displayName,
    required this.userName,
    required this.email,
    required this.profilePic,
    this.subscription = const [],
    this.videos = 0,
    this.userId = '',
    this.description = '',
    this.type = '',
  });

  // Convert a UserModel into a Map.
  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'userName': userName,
      'email': email,
      'profilePic': profilePic,
      'subscription': subscription,
      'videos': videos,
      'userId': userId,
      'description': description,
      'type': type,
    };
  }

  // Convert a Map into a UserModel.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      displayName: map['displayName'] ?? '',
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
      profilePic: map['profilePic'] ?? '',
      subscription: List<String>.from(map['subscription'] ?? []),
      videos: map['videos'] is int ? map['videos'] : int.parse(map['videos'].toString()),
      userId: map['userId'] ?? '',
      description: map['description'] ?? '',
      type: map['type'] ?? '',
    );
  }

  // Convert a UserModel to JSON string.
  String toJson() => json.encode(toMap());

  // Convert a JSON string into a UserModel.
  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
