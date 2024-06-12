import 'dart:developer';

import 'package:burger_repository/src/burger_repo.dart';
import 'package:burger_repository/src/entities/entities.dart';
import 'package:burger_repository/src/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseBurgerRepo implements BurgerRepo {
  final burgerCollection = FirebaseFirestore.instance.collection('burgers');

@override
  Future<List<Burger>> getBurgers() async {
    try {
      return await burgerCollection
        .get()
        .then((value) => value.docs.map((e) => 
          Burger.fromEntity(BurgerEntity.fromDocument(e.data()))
        ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}