import 'package:intl/intl.dart';

class HumansFormats {
  
  static String humanReadbleNumbers (double number){

    return NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en'
    ).format(number);

  }

}