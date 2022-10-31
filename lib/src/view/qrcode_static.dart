import 'package:app_pix/src/models/entities/pix.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_pix/src/models/index.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../commoms/index.dart';
import 'index.dart';

class QrCodeStaticScreen extends StatefulWidget {
  QrCodeStaticScreen({Key? key}) : super(key: key);

  @override
  _QrCodeStaticScreenState createState() => _QrCodeStaticScreenState();
}

class _QrCodeStaticScreenState extends State<QrCodeStaticScreen> {
  var pixModel = PixModel();
  var pixEntity = PixEntity();

  final _formKey = GlobalKey<FormState>();

  var name = TextEditingController();
  var city = TextEditingController();
  var pixKey = TextEditingController();
  var idTransaction = TextEditingController();
  var message = TextEditingController();
  var amount = TextEditingController();
  var code = '';
  bool clickButton = false;

  var typePixKeyList = ['E-mail', 'Telefone', 'CPF', 'CNPJ', 'Outro'];
  var typePixKeySelected;
  String textHint = '';
  String textLabel = '';

  var maskCurrency = MaskTextInputFormatter(
      mask: 'R\$##.##0,00', filter: {"#": RegExp(r'[0-9]')});
  var maskPixKey = MaskTextInputFormatter();

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
            child: Form(
              key: _formKey,
              child: Container(
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
                    Row(
                      children: [
                        SizedBox(
                          width: 100.0,
                          child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                label: Text('Chave Pix*'),
                                border: InputBorder.none,
                              ),
                              value: typePixKeySelected,
                              items: typePixKeyList
                                  .map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  typePixKeySelected = value!;
                                });
                                formField(typePixKeySelected);
                              }),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: TextFormField(
                            enabled: typePixKeySelected == null ? false : true,
                            controller: pixKey,
                            style: TextStyle(fontSize: 14),
                            maxLength: 25,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text(typePixKeySelected == null
                                  ? 'Informe o tipo da chave pix'
                                  : textLabel),
                              hintText: textHint,
                              counterText: '',
                              errorStyle: TextStyle(fontSize: 5),
                              suffixIcon: IconButton(
                                onPressed: () => pixKey.clear(),
                                icon: Icon(
                                  Icons.cancel,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.7),
                                ),
                              ),
                            ),
                            inputFormatters: [maskPixKey],
                            validator: (value) {
                              return value == null || value.isEmpty ? '' : null;
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: name,
                      style: TextStyle(fontSize: 14),
                      maxLength: 25,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Destinatário*',
                        counterText: '',
                        suffixIcon: IconButton(
                          onPressed: () => name.clear(),
                          icon: Icon(
                            Icons.cancel,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                      validator: (value) {
                        return value == null || value.isEmpty ? '' : null;
                      },
                    ),
                    TextFormField(
                      controller: city,
                      maxLength: 15,
                      style: TextStyle(fontSize: 14),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Cidade do Destinatário*',
                        counterText: '',
                        suffixIcon: IconButton(
                          onPressed: () => city.clear(),
                          icon: Icon(
                            Icons.cancel,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                      validator: (value) {
                        return value == null || value.isEmpty ? '' : null;
                      },
                    ),
                    TextFormField(
                      controller: idTransaction,
                      maxLength: 25,
                      style: TextStyle(fontSize: 14),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Identificador',
                        counterText: '',
                        suffixIcon: IconButton(
                          onPressed: () => idTransaction.clear(),
                          icon: Icon(
                            Icons.cancel,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: amount,
                      maxLength: 25,
                      style: TextStyle(fontSize: 14),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Valor*',
                        counterText: '',
                        hintText: 'R\$ 0,00',
                        suffixIcon: IconButton(
                          onPressed: () => amount.clear(),
                          icon: Icon(
                            Icons.cancel,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                      inputFormatters: [
                        CurrencyTextInputFormatter(
                            locale: 'pt_BR', symbol: 'R\$')
                      ],
                      validator: (value) {
                        return value == null || value.isEmpty ? '' : null;
                      },
                    ),
                    TextFormField(
                      controller: message,
                      maxLength: 25,
                      style: TextStyle(fontSize: 14),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Mensagem',
                        counterText: '',
                        suffixIcon: IconButton(
                          onPressed: () => message.clear(),
                          icon: Icon(
                            Icons.cancel,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() => clickButton = true);
                          if (_formKey.currentState!.validate()) {
                            var pixKeyFormat = '';
                            if (typePixKeySelected != 'E-mail' &&
                                typePixKeySelected != 'Outro') {
                              pixKeyFormat = pixKey.text.replaceAll(
                                  RegExp(r'[~!?@/#$%.^&*()_-\s]'), '');
                            } else {
                              pixKeyFormat = pixKey.text;
                            }

                            pixEntity.setMessage = message.text;
                            pixEntity.setPixKey = pixKeyFormat;
                            pixEntity.setName = name.text;
                            pixEntity.setCity = city.text;
                            pixEntity.setIdTransaction = idTransaction.text;
                            pixEntity.setAmount =
                                Tools.formatCurrency(amount.text);

                            code = (await pixModel.generatedPixModel(
                                pixEntity, true, fail: (msg) {
                              Tools.snackBar(context, msg);
                              setState(() => clickButton = false);
                            }))!;

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    QrCodePixScreen(
                                  qrCode: code,
                                ),
                              ),
                            );
                          } else {
                            setState(() => clickButton = false);
                            Tools.snackBar(context,
                                'Por favor, preencha os campos destacados.');
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
            ),
          ),
        ],
      ),
    );
  }

  formField(String type) {
    switch (type) {
      case 'E-mail':
        textLabel = 'E-mail';
        textHint = 'email@example.com';
        maskPixKey = MaskTextInputFormatter();
        pixKey.clear();
        break;
      case 'Telefone':
        textLabel = 'Telefone';
        textHint = '(xx)1111-1111';
        maskPixKey = MaskTextInputFormatter(
            mask: '+55(##)#####-####', filter: {"#": RegExp(r'[0-9]')});
        pixKey.clear();
        break;
      case 'CPF':
        textLabel = 'CPF';
        textHint = '222.222.222-22';
        maskPixKey = MaskTextInputFormatter(
            mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
        pixKey.clear();
        break;
      case 'CNPJ':
        textLabel = 'CNPJ';
        textHint = '22.222.222/0001-22';
        maskPixKey = MaskTextInputFormatter(
            mask: '##.###.###/####-##', filter: {"#": RegExp(r'[0-9]')});
        pixKey.clear();
        break;
      case 'Outro':
        textLabel = 'Chave Aleatória';
        textHint = '';
        maskPixKey = MaskTextInputFormatter();
        pixKey.clear();
        break;
      default:
        textLabel = 'Chave Pix';
        textHint = '';
        maskPixKey = MaskTextInputFormatter();
        pixKey.clear();
    }
  }
}
