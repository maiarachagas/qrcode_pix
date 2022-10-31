import 'package:cloud_firestore/cloud_firestore.dart';

class DonationEntity {
  int? _id;
  String? _to;
  String? _from;
  String? _message;
  String? _idTransaction;
  String? _amount;
  Timestamp? _dateDonation;

  //Getter
  int? get getId => _id;

  String? get getTo => _to;

  String? get getFrom => _from;

  String? get getMessage => _message;

  String? get getIdTransaction => _idTransaction;

  String? get getAmount => _amount;

  Timestamp? get getDateDonation => _dateDonation;

  DonationEntity.fromJson(Map<String, dynamic> doc) {
    _id = doc['id'] ?? 0;
    _to = doc['to'] ?? "";
    _from = doc['from'] ?? "";
    _message = doc['message'] ?? "";
    _idTransaction = doc['idTransaction'] ?? "";
    _amount = doc['amount'] ?? "0.00";
    _dateDonation = doc['dateDonation'] ?? Timestamp.now();
  }
}
