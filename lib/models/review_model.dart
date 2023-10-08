import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String senderName;
  final String reviewController;
  final String rating;
  final String attendanceDate;
  final String profilePicture;
  final Timestamp timestamp;

  const ReviewModel({
    required this.senderName,
    required this.reviewController,
    required this.rating,
    required this.attendanceDate,
    required this.profilePicture,
    required this.timestamp,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      senderName: json["senderName"] as String? ?? '',
      reviewController: json["reviewController"] as String? ?? '',
      rating: json["rating"] as String? ?? '',
      attendanceDate: json["attendanceDate"] as String? ?? '',
      profilePicture: json["profilePicture"],
      timestamp: json['timestamp'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderName': senderName,
      'reviewController': reviewController,
      'rating': rating,
      'attendanceDate': attendanceDate,
      'profilePicture': profilePicture,
      'timestamp': timestamp,
    };
  }
}
