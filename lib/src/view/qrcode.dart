import 'package:app_pix/src/commoms/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePixScreen extends StatelessWidget {
  final String qrCode;

  const QrCodePixScreen({required this.qrCode});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Center(
        child: Container(
          width: kIsWeb ? size.width / 3.5 : size.width / 1.5,
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Text(
                'Escaneie o Qr Code abaixo ou copie o código pix para concluir sua doação',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                height: 200,
                width: 200,
                child: qrCode.isEmpty
                    ? Image.asset('assets/images/qrcode-empty.png')
                    : QrImage(data: qrCode),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(3.0),
                child: Flexible(
                  child: Text(
                    'Pix Copia e Cola: $qrCode',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              qrCode.isEmpty
                  ? Container()
                  : SizedBox(
                      width: kIsWeb ? size.width / 3 : size.width / 1.2,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: qrCode));
                          Tools.snackBar(
                              context, 'Código Pix copiado com sucesso!');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text('Pix Copia e Cola'),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
