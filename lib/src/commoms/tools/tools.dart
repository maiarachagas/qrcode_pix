import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tools {
  static String formatDateWithTime(Timestamp timestamp) {
    var format = DateFormat('dd/MM/yy - hh:mm');
    var date = format.format(timestamp.toDate());
    return date;
  }

  static String formatDate(Timestamp timestamp) {
    var format = DateFormat('dd/MM/yy');
    var date = format.format(timestamp.toDate());
    return date;
  }

  static formatCurrency(String amount) {
    var formatValue = amount.replaceAll(RegExp(r'[A-Za-z~!?@#$%^&*_-\s]'), '');
    if (amount.length > 5) {
      return formatValue
          .replaceFirst(RegExp(r'[.]'), '')
          .replaceAll(RegExp(r'[,]'), '.');
    } else {
      return formatValue;
    }
  }

  static formatAmount(String amount) {
    double value = double.parse(amount);
    var format = NumberFormat("#,##0.00", "pt_BR");
    var newAmount = "R\$ " + format.format(value / 100);
    return newAmount;
  }

  static snackBar(BuildContext context, String? msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg!,
          style: TextStyle(fontSize: 12),
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
      ),
    );
  }
}
