class PixEntity {
  int? _id;
  String? _name;
  String? _city;
  String? _idTransaction;
  String? _pixKey;
  String? _amount;
  String? _message;
  String? _from;

  PixEntity(
      [this._pixKey,
      this._name,
      this._city,
      this._message,
      this._idTransaction,
      this._amount,
      this._from]);

  //Getter
  int? get getId => _id;

  String? get getPixKey => _pixKey;

  String? get getName => _name;

  String? get getFrom => _from;

  String? get getCity => _city;

  String? get getIdTransaction => _idTransaction;

  String? get getAmount => _amount;

  String? get getMessage => _message;

  //Setters
  set setId(int id) => _id = id;

  set setPixKey(String pixKey) => _pixKey = pixKey;

  set setName(String name) => _name = name;

  set setFrom(String from) => _from = from;

  set setCity(String city) => _city = city;

  set setIdTransaction(String idTransaction) => _idTransaction = idTransaction;

  set setAmount(String amount) => _amount = amount;

  set setMessage(String message) => _message = message;

  //Json
  PixEntity.fromJson(Map<String, dynamic> doc) {
    _id = doc['id'] ?? 0;
    _pixKey = doc['pixKey'] ?? "";
    _idTransaction = doc['idTransaction'] ?? "";
    _name = doc['name'] ?? "";
    _city = doc['city'] ?? "";
  }
}
