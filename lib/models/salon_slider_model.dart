import 'package:cloud_firestore/cloud_firestore.dart';

class SalonSliderModel {
  String id;
  int? totalSize;
  int? typeId;
  int? offset;
  List<Salons>? salons;

  SalonSliderModel(
      {required this.id,
      required this.totalSize,
      required this.typeId,
      required this.offset,
      required this.salons});

  SalonSliderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        totalSize = json['total_size'],
        typeId = json['type_id'],
        offset = json['offset'],
        salons = (json['salons'] as List)
            .map((dynamic e) => Salons.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_size'] = this.totalSize;
    data['type_id'] = this.typeId;
    data['offset'] = this.offset;
    return data;
  }
}

class Salons {
  String id;
  String name;
  String description;
  int stars;
  String img;
  String location;
  int typeId;

  Salons(
      {required this.id,
      required this.name,
      required this.description,
      required this.stars,
      required this.img,
      required this.location,
      required this.typeId});

  Salons.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        stars = json['stars'],
        img = json['img'],
        location = json['location'],
        typeId = json['type_id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['stars'] = this.stars;
    data['img'] = this.img;
    data['location'] = this.location;
    data['type_id'] = this.typeId;
    return data;
  }
}
