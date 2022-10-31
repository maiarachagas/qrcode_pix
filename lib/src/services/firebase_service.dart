import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/entities/index.dart';

class FirebaseServices {
  var _db = FirebaseFirestore.instance;

  Future<PixEntity> getInfoPix() async {
    return await _db
        .collection('pix')
        .doc('infoPix')
        .get()
        .then((value) => PixEntity.fromJson(value.data()!));
  }

  Future<int?> incrementId(int id) async {
    await _db.collection('pix').doc('infoPix').update({
      'id': id,
    });
    return id;
  }

  Future addDonation(PixEntity pixEntity) async {
    return await _db
        .collection('pix')
        .doc('infoPix')
        .collection('donation')
        .doc(pixEntity.getId!.toString())
        .set({
      'id': pixEntity.getId,
      'to': pixEntity.getName,
      'from': pixEntity.getFrom == null || pixEntity.getFrom!.isEmpty
          ? "Anônimo"
          : pixEntity.getFrom,
      'amount': pixEntity.getAmount,
      'message': pixEntity.getMessage ?? "",
      'idTransaction': "${pixEntity.getIdTransaction}${pixEntity.getId}",
      'dateDonation': Timestamp.now(),
    });
  }

  Future<List<DonationEntity>> getAllDonations() async {
    return await _db
        .collection('pix')
        .doc('infoPix')
        .collection('donation')
        .get()
        .then((value) =>
            value.docs.map((e) => DonationEntity.fromJson(e.data())).toList());
  }

  Future<DonationEntity> getDonationsById(int? id) async {
    return await _db
        .collection('pix')
        .doc('infoPix')
        .collection('donation')
        .doc(id.toString())
        .get()
        .then((value) => DonationEntity.fromJson(value.data()!));
  }
}
