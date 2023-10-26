import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String uid;
  final String senderName;
  final String reviewController;
  double reviewRating;
  final String attendanceDate;
  final String profilePicture;
  final Timestamp timestamp;

  ReviewModel({
    required this.uid,
    required this.senderName,
    required this.reviewController,
    required this.reviewRating, //used to calculate totalRating in salonModel (result_widget)
    required this.attendanceDate,
    required this.profilePicture,
    required this.timestamp,
  });

  void updateReviewRating(double newReviewRating) {
    reviewRating = newReviewRating;
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      uid: json["uid"] as String? ?? '',
      senderName: json["senderName"] as String? ?? '',
      reviewController: json["reviewController"] as String? ?? '',
      reviewRating: json["reviewRating"] as double? ?? 0.0,
      attendanceDate: json["attendanceDate"] as String? ?? '',
      profilePicture: json["profilePicture"],
      timestamp: json['timestamp'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'senderName': senderName,
      'reviewController': reviewController,
      'reviewRating': reviewRating,
      'attendanceDate': attendanceDate,
      'profilePicture': profilePicture,
      'timestamp': timestamp,
    };
  }
}
