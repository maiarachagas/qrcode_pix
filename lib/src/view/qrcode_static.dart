import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_pix/src/models/index.dart';

import 'index.dart';

class QrCodeStaticScreen extends StatefulWidget {
  QrCodeStaticScreen({Key? key}) : super(key: key);

  @override
  _QrCodeStaticScreenState createState() => _QrCodeStaticScreenState();
}

class _QrCodeStaticScreenState extends State<QrCodeStaticScreen> {
  var code = '';
  var name = TextEditingController();
  var city = TextEditingController();
  var pixKey = TextEditingController();
  var idTransaction = TextEditingController();
  var message = TextEditingController();
  var amount = TextEditingController();

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Após preencher as informações e clicar no botão, você será direcionado para o QR Code.'),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: pixKey,
                        maxLength: 25,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Chave Pix', counterText: ''),
                      ),
                      TextFormField(
                        controller: name,
                        maxLength: 25,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            labelText: 'Destinatário', counterText: ''),
                      ),
                      TextFormField(
                        controller: city,
                        maxLength: 25,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Cidade do Destinatário',
                            counterText: ''),
                      ),
                      TextFormField(
                        controller: idTransaction,
                        maxLength: 25,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Identificador', counterText: ''),
                      ),
                      TextFormField(
                        controller: amount,
                        maxLength: 25,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Valor', counterText: ''),
                      ),
                      TextFormField(
                        controller: message,
                        maxLength: 25,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Mensagem', counterText: ''),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            print('######## 1');
                            pixModel.createCodePix(
                                message.text,
                                pixKey.text,
                                name.text,
                                city.text,
                                idTransaction.text,
                                amount);
                            print('######## 2');

                            code = pixModel.generatePixStatic(pixModel)!;
                            print('######## 3');

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
