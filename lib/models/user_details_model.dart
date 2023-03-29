class UserDetailsModel {
  final String name;
  final String country;
  UserDetailsModel({required this.name, required this.country});

  Map<String, dynamic> getJson() => {
        'name': name,
        'country': country,
      };
}
