import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/entities/pix.dart';

class PixService {
  var _domain = 'services-cc.herokuapp.com';
  var _header = {'Content-Type': 'application/json'};

  Future<String> generatedPixService(
      PixEntity pixEntity, bool isDonation) async {
    try {
      var code = '';
      var idTransaction = "";

      if (pixEntity.getIdTransaction != null ||
          pixEntity.getIdTransaction!.isNotEmpty) {
        if (isDonation) {
          idTransaction = '${pixEntity.getIdTransaction}${pixEntity.getId}';
        } else {
          idTransaction = pixEntity.getIdTransaction!;
        }
      }

      var url = Uri.https(_domain, "/pix/");
      var res = await http.post(url,
          body: jsonEncode({
            "pixKey": pixEntity.getPixKey,
            "name": pixEntity.getName,
            "city": pixEntity.getCity,
            "idTransaction": idTransaction,
            "amount": pixEntity.getAmount,
            "message": pixEntity.getMessage ?? ""
          }),
          headers: _header);

      if (res.statusCode == 201) {
        var body = jsonDecode(res.body);

        code = body["key"];
        return code;
      } else {
        throw "Erro: ${res.body}";
      }
    } catch (e) {
      print('[Pix Service]: $e');
      rethrow;
    }
  }
}
