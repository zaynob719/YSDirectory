class UserDetailsModel {
  final String uid;
  final String name;
  String? lastName;
  final String emailAddress;
  String? profilePicture;
  String? city;
  double? userLat;
  double? userLng;
  List<String> bookmarkedSalonIds;

  UserDetailsModel({
    required this.uid,
    required this.name,
    this.lastName,
    required this.emailAddress,
    this.city,
    this.userLat,
    this.userLng,
    this.profilePicture,
    List<String>? bookmarkedSalonIds,
  }) : bookmarkedSalonIds = bookmarkedSalonIds ?? [];

  void updateCity(String newCity) {
    city = newCity;
  }

  void updateUserLat(double newUserLat) {
    userLat = newUserLat;
  }

  void updateUserLng(double newUserLng) {
    userLng = newUserLng;
  }

  void updateProfilePictureUrl(String newUrl) {
    profilePicture = newUrl;
  }

  void addBookmark(String salonId) {
    if (!bookmarkedSalonIds.contains(salonId)) {
      bookmarkedSalonIds.add(salonId);
    }
  }

  void removeBookmark(String salonId) {
    bookmarkedSalonIds.remove(salonId);
  }

  Map<String, dynamic> getJson() => {
        'uid': uid,
        'name': name,
        'lastName': lastName,
        'emailAddress': emailAddress,
        'city': city,
        'userLat': userLat,
        'userLng': userLng,
        'profilePicture': profilePicture,
        'bookmarkedSalonIds': bookmarkedSalonIds,
      };
  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      uid: json["uid"],
      name: json["name"],
      lastName: json["lastName"],
      emailAddress: json["emailAddress"],
      city: json["city"],
      userLat: json["userLat"],
      userLng: json["userLng"],
      profilePicture: json["profilePicture"],
      bookmarkedSalonIds: json["bookmarkedSalonIds"] != null
          ? List<String>.from(json["bookmarkedSalonIds"])
          : [],
    );
  }
}
