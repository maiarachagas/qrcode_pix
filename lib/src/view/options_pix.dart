import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'index.dart';

class PixOptionScreen extends StatefulWidget {
  @override
  _PixOptionScreenState createState() => _PixOptionScreenState();
}

class _PixOptionScreenState extends State<PixOptionScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Container(
          width: kIsWeb ? size.width / 3.5 : size.width / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'Seja Bem Vindo!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Aqui você conseguirá gerar um Qr Code para Pix e fazer uma doação através do Pix também!',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 100),
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => QrCodeStaticScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  icon: Icon(Icons.qr_code),
                  label: Text(
                    'Gerar Qr Code Estático'.toUpperCase(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DonationPixScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  icon: Icon(Icons.volunteer_activism_outlined),
                  label: Text(
                    'Doação'.toUpperCase(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
