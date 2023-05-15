class UserDetailsModel {
  final String name;
  final String city;
  UserDetailsModel({required this.name, required this.city});

  Map<String, dynamic> getJson() => {
        'name': name,
        'city': city,
      };
  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(name: json["name"], city: json["city"]);
  }
}
