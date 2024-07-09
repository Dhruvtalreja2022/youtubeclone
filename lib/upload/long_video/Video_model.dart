import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  final String videoUrl;
  final String thumbnail;
  final String title;
  final DateTime datePublished;
  final int views;
  final String videoId;
  final String userId;
  final List likes;
  final String type;

  VideoModel({
    required this.videoUrl,
    required this.thumbnail,
    required this.title,
    required this.datePublished,
    required this.views,
    required this.videoId,
    required this.userId,
    required this.likes,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'videoUrl': videoUrl,
      'thumbnail': thumbnail,
      'title': title,
      'datePublished': datePublished,
      'views': views,
      'videoId': videoId,
      'userId': userId,
      'likes': likes,
      'type': type,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      videoUrl: map['videoUrl'] ?? '', // Default to empty string if null
      thumbnail: map['thumbnail'] ?? '', // Default to empty string if null
      title: map['title'] ?? '', // Default to empty string if null
      datePublished: map['datePublished'] is Timestamp
          ? (map['datePublished'] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(
        map['datePublished'] ?? DateTime.now().millisecondsSinceEpoch,
      ),
      views: (map['views'] ?? 0) as int, // Default to 0 if null
      videoId: map['videoId'] ?? '', // Default to empty string if null
      userId: map['userId'] ?? '', // Default to empty string if null
      likes: List.from(map['likes'] ?? []), // Default to empty list if null
      type: map['type'] ?? '', // Default to empty string if null
    );
  }
}
