import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_pix/src/models/index.dart';

import 'index.dart';

class DonationPixScreen extends StatefulWidget {
  @override
  _DonationPixScreenState createState() => _DonationPixScreenState();
}

class _DonationPixScreenState extends State<DonationPixScreen> {
  var amountController = TextEditingController();
  List<double> amounts = [10.0, 30.0, 50.0];
  List<dynamic> selectAmount = [false, false, false];
  String? amount = '';
  String code = '';
  int? clickedIndex;
  bool onClicked = false;

  var pixModel = PixModel();

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
                                      if (onClicked) {
                                        setState(() {
                                          onClicked = false;
                                          clickedIndex = null;
                                          amount = '0.00';
                                        });
                                      } else {
                                        setState(() {
                                          onClicked = true;
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
                          hintText: 'R\$ outro',
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
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
                            pixModel.createCodePix(
                                'Doação',
                                pixModel.pixEntity.getPixKey!,
                                pixModel.pixEntity.getName,
                                pixModel.pixEntity.getCity,
                                pixModel.pixEntity.getIdTransaction,
                                amount);

                            code = pixModel.generatePixStatic(pixModel)!;

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    QrCodePixScreen(
                                  qrCode: code,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text('Gerar Qr Code'),
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
