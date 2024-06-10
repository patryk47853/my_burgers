import 'package:burger_repository/src/entities/macros_entity.dart';

import '../models/models.dart';

class BurgerEntity {
  String burgerId;
  String picture;
  bool isVeg;
  int spicy;
  String name;
  String description;
  int price;
  int discount;
  Macros macros;

  BurgerEntity({
    required this.burgerId,
    required this.picture,
    required this.isVeg,
    required this.spicy,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.macros,
  });

  Map<String, Object?> toDocument() {
    return {
      'burgerId': burgerId,
      'picture': picture,
      'isVeg': isVeg,
      'spicy': spicy,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'macros': macros.toEntity().toDocument(),
    };
  }

  static BurgerEntity fromDocument(Map<String, dynamic> doc) {
    return BurgerEntity(
      burgerId: doc['burgerId'],
      picture: doc['picture'],
      isVeg: doc['isVeg'],
      spicy: doc['spicy'],
      name: doc['name'],
      description: doc['description'],
      price: doc['price'],
      discount: doc['discount'],
      macros: Macros.fromEntity(MacrosEntity.fromDocument(doc['macros'])),
    );
  }
}