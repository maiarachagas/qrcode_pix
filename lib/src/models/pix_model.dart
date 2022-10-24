import 'package:app_pix/src/models/entities/pix.dart';
import 'package:app_pix/src/services/pix_service.dart';

class PixModel {
  var pixEntity = PixEntity();

  String? merchantAccountInformation(String pix) {
    var pixLength = pix.length;
    var guiLength = pixEntity.getGUI!.length;
    var msgLength = pixEntity.getMessage!.length;
    var sumMsg = '${pixEntity.getIdMessage}$msgLength'.length;
    var sumGUI = '${pixEntity.getIdGUI}$guiLength'.length;
    var sumPix = '${pixEntity.getIdPix}$pixLength'.length;
    var sumInformation;

    if (pixEntity.getMessage!.isEmpty) {
      sumInformation = guiLength + pixLength + sumGUI + sumPix;
      pixEntity.setPixKey =
          '${pixEntity.getIdMerchantAccount}$sumInformation${pixEntity.getIdGUI}$guiLength${pixEntity.getGUI}${pixEntity.getIdPix}$pixLength$pix';
    } else {
      sumInformation =
          guiLength + pixLength + msgLength + sumGUI + sumPix + sumMsg;
      var msg = msgLength < 10 ? '0$msgLength' : msgLength;
      pixEntity.setPixKey =
          '${pixEntity.getIdMerchantAccount}$sumInformation${pixEntity.getIdGUI}$guiLength${pixEntity.getGUI}${pixEntity.getIdPix}$pixLength$pix${pixEntity.getIdMessage}$msg${pixEntity.getMessage}';

      return pixEntity.getPixKey;
    }
  }

  String? merchantName(String merchantName) {
    var merchantNameLength = merchantName.length < 10
        ? '0${merchantName.length}'
        : merchantName.length;

    var key = '$merchantNameLength$merchantName';
    pixEntity.setName = '${pixEntity.getIdMerchantName}$key';

    return pixEntity.getName;
  }

  String? merchantCity(String merchantCity) {
    var merchantCityLength = merchantCity.length < 10
        ? '0${merchantCity.length}'
        : merchantCity.length;

    var key = '$merchantCityLength$merchantCity';
    pixEntity.setCity = '${pixEntity.getIdMerchantCity}$key';

    return pixEntity.getCity;
  }

  String? transaction(String codeTransiction) {
    if (codeTransiction.isEmpty) {
      codeTransiction = '***';
    }
    var codeTransictionLength = codeTransiction.length < 10
        ? '0${codeTransiction.length}'
        : codeTransiction.length;

    var code = '$codeTransictionLength$codeTransiction';
    pixEntity.setIdTransaction =
        '${pixEntity.getIdAdditionalDataFieldTemplate}$code';
    return pixEntity.getIdTransaction;
  }

  String? message(String codeMessage) {
    pixEntity.setMessage = '$codeMessage';

    return pixEntity.getMessage;
  }

  String? amount(String amountTransiction) {
    var amountTransictionLength = amountTransiction.length < 10
        ? '0${amountTransiction.length}'
        : amountTransiction.length;

    var key = '$amountTransictionLength$amountTransiction';
    pixEntity.setAmount = '${pixEntity.getIdTransactionAmount}$key';
    return pixEntity.getAmount;
  }

  void createCodePix(
      String msg, String pixKey, name, city, idTransaction, value) {
    message(msg);
    merchantAccountInformation(pixKey);
    merchantName(name);
    merchantCity(city);
    transaction(idTransaction);
    amount(value);
  }

  String? generatePixStatic(PixModel model) {
    return PixService().generatePixStatic(model);
  }
}
