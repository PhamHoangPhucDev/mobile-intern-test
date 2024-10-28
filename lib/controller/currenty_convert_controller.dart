import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/currency_model.dart';

class CurrentyConvertController {
  final TextEditingController moneyController = TextEditingController();
  String convertedValue = '';
  String targetCurrency = 'EUR';
  String selectedCurrency = 'USD';
  CurrencyRate? currencyRate;
  String? errorMessage;

  Future<CurrencyRate> fetchExchangeRates(context) async {
    try {
      final response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/$selectedCurrency'));
      if (response.statusCode == 200) {
        return CurrencyRate.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load exchange rates');
      }
    } catch (e) {
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return CurrencyRate(base: '',rates: Map());
  }

}