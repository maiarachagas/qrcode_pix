class PixEntity {
  String _name = 'Maria Silva';
  String _city = 'Sao Paulo';
  String _idTransaction = '***';
  String _pixKey = 'xxxxxx@gmail.com';
  String _amount = '0.00';
  String _gui = 'br.gov.bcb.pix';
  String _message = '';
  String _idMessage = '02';
  String _idGUI = '00';
  String _idPix = '01';
  String _idPayloadFormatIndicator = '000201';
  String _idMerchantAccount = '26';
  String _idMerchantCategoryCode = '52040000';
  String _idTransactionCurrency = '5303986';
  String _idTransactionAmount = '54';
  String _idCountryCode = '5802BR';
  String _idMerchantName = '59';
  String _idMerchantCity = '60';
  String _idAdditionalDataFieldTemplate = '620705';
  String _idCRC16 = '6304';

//Getter
  String? get getPixKey => _pixKey;

  String? get getName => _name;

  String? get getCity => _city;

  String? get getIdTransaction => _idTransaction;

  String? get getAmount => _amount;

  String? get getGUI => _gui;

  String? get getMessage => _message;

  String? get getIdMessage => _idMessage;

  String? get getIdGUI => _idGUI;

  String? get getIdPix => _idPix;

  String? get getIdPayloadFormatIndicator => _idPayloadFormatIndicator;

  String? get getIdMerchantAccount => _idMerchantAccount;

  String? get getIdMerchantCategoryCode => _idMerchantCategoryCode;

  String? get getIdTransactionCurrency => _idTransactionCurrency;

  String? get getIdTransactionAmount => _idTransactionAmount;

  String? get getIdCountryCode => _idCountryCode;

  String? get getIdMerchantName => _idMerchantName;

  String? get getIdMerchantCity => _idMerchantCity;

  String? get getIdAdditionalDataFieldTemplate =>
      _idAdditionalDataFieldTemplate;

  String? get getIdCRC16 => _idCRC16;

  //Setters
  set setPixKey(String pixKey) => _pixKey = pixKey;

  set setName(String name) => _name = name;

  set setCity(String city) => _city = city;

  set setIdTransaction(String idTransaction) => _idTransaction = idTransaction;

  set setAmount(String amount) => _amount = amount;

  set setGUI(String gui) => _gui = gui;

  set setMessage(String message) => _message = message;
}
