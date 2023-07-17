class ReviewModel {
  final String senderName;
  final String reviewController;
  final String rating;
  final String attendanceDate;
  final String userAvatar;

  const ReviewModel({
    required this.senderName,
    required this.reviewController,
    required this.rating,
    required this.attendanceDate,
    required this.userAvatar,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      senderName: json["senderName"] as String? ?? '',
      reviewController: json["reviewController"] as String? ?? '',
      rating: json["rating"] as String? ?? '',
      attendanceDate: json["attendanceDate"] as String? ?? '',
      userAvatar: json['userAvatar'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderName': senderName,
      'reviewController': reviewController,
      'rating': rating,
      'attendanceDate': attendanceDate,
      'userAvatar': userAvatar,
    };
  }
}
