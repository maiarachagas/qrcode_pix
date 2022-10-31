import '../services/index.dart';
import 'entities/index.dart';

class DonationModel {
  var _fbservice = FirebaseServices();

  Future createDonation(PixEntity pixEntity) async {
    pixEntity.setId = (await _fbservice.incrementId(pixEntity.getId! + 1))!;
    await _fbservice.addDonation(pixEntity);
  }

  Future<List<DonationEntity>> getAllDonations() async =>
      await _fbservice.getAllDonations();

  Future<DonationEntity> getDonationsById(int? id) async =>
      await _fbservice.getDonationsById(id);
}
