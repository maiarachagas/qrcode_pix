import 'dart:convert';
import 'dart:typed_data';

import 'package:app_pix/src/models/pix_model.dart';
import 'package:hex/hex.dart';

class PixService {
  String? generatePixStatic(PixModel model) {
    var payload =
        '${model.pixEntity.getIdPayloadFormatIndicator}${model.pixEntity.getPixKey}${model.pixEntity.getIdMerchantCategoryCode}${model.pixEntity.getIdTransactionCurrency}${model.pixEntity.getAmount}${model.pixEntity.getIdCountryCode}${model.pixEntity.getName}${model.pixEntity.getCity}${model.pixEntity.getIdTransaction}${model.pixEntity.getIdCRC16}';

    var crc = crc16(payload);
    var pix = payload + crc!;
    print(pix);

    return pix;
  }

  String? crc16(String payload) {
    var bytes = utf8.encode(payload);

    // CCITT
    const POLYNOMIAL = 0x1021;
    // XMODEM
    const INIT_VALUE = 0xFFFF;

    final bitRange = Iterable.generate(8);

    var crc = INIT_VALUE;
    for (var byte in bytes) {
      crc ^= (byte << 8);
      // ignore: unused_local_variable
      for (var i in bitRange) {
        crc = (crc & 0x8000) != 0 ? (crc << 1) ^ POLYNOMIAL : crc << 1;
      }
    }

    var byteData = ByteData(2)..setInt16(0, crc, Endian.little);
    var hex = numToHex(byteData.buffer.asUint8List());
    return hex;
  }

  String? numToHex(n) {
    var hex = HEX.encode(n);
    var hexFormatted = hex.substring(2) + hex.substring(0, 2);

    return hexFormatted.toUpperCase();
  }
}
