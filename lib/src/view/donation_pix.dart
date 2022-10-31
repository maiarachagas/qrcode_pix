import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_pix/src/models/index.dart';

import '../commoms/index.dart';
import '../models/entities/pix.dart';
import 'index.dart';

class DonationPixScreen extends StatefulWidget {
  @override
  _DonationPixScreenState createState() => _DonationPixScreenState();
}

class _DonationPixScreenState extends State<DonationPixScreen> {
  var pixModel = PixModel();
  var pixEntity = PixEntity();
  var donationModel = DonationModel();

  var amountController = TextEditingController();
  List<double> amounts = [10.0, 30.0, 50.0];
  List<dynamic> selectValue = [false, false, false];
  String? amount = '';
  String code = '';
  int? clickedIndex;
  bool selectAmount = false;
  bool clickButton = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey.shade800,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: kIsWeb ? size.width / 3 : size.width / 1.2,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Após informar o valor e clicar no botão, você será direcionado para o QR Code'),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Selecione um valor'),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        child: Center(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: amounts.length,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (selectAmount) {
                                        setState(() {
                                          selectAmount = false;
                                          clickedIndex = null;
                                          amount = '0.00';
                                        });
                                      } else {
                                        setState(() {
                                          selectAmount = true;
                                          clickedIndex = index;
                                          amount =
                                              amounts[index].toStringAsFixed(2);
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: clickedIndex == index
                                            ? Colors.purple.shade200
                                            : Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: clickedIndex == index
                                                ? Colors.purple.shade200
                                                : Colors.grey.shade200),
                                      ),
                                      child: Text(
                                          'R\$ ${amounts[index].toStringAsFixed(2)}'),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: amountController,
                        decoration: InputDecoration(
                          labelText: 'Valor',
                          hintText: 'R\$ 0.00',
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => amountController.clear(),
                            icon: Icon(
                              Icons.cancel,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.7),
                            ),
                          ),
                        ),
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                              locale: 'pt_BR', symbol: 'R\$'),
                        ],
                        onChanged: (value) {
                          if (amountController.text.isNotEmpty) {
                            setState(() {
                              clickedIndex = null;
                              amount = amountController.text;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: kIsWeb ? size.width / 3 : size.width / 1.2,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() => clickButton = true);

                            if (amount!.isEmpty) {
                              setState(() => clickButton = false);
                              Tools.snackBar(context,
                                  'Por favor, informe o valor a ser doado.');
                            } else {
                              pixEntity = await pixModel.getInfoPix();
                              pixEntity.setAmount =
                                  Tools.formatCurrency(amount!);

                              code = (await pixModel.generatedPixModel(
                                  pixEntity, true, fail: (msg) {
                                Tools.snackBar(context, msg);
                                setState(() => clickButton = false);
                              }))!;
                              await donationModel.createDonation(pixEntity);

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      QrCodePixScreen(
                                    qrCode: code,
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: clickButton
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    color: Colors.white,
                                  ),
                                )
                              : Text('Gerar Qr Code'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
