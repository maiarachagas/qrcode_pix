import 'package:app_pix/src/models/entities/pix.dart';

import '../services/index.dart';

class PixModel {
  var _fbservice = FirebaseServices();
  var _service = PixService();

  Future<PixEntity> getInfoPix() async => await _fbservice.getInfoPix();

  Future<String?> generatedPixModel(PixEntity pixEntity, bool isDonation,
      {Function? fail}) async {
    try {
      return await _service.generatedPixService(pixEntity, isDonation);
    } catch (e) {
      throw fail!(e.toString());
    }
  }
}
