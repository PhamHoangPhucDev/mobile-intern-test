import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/currenty_convert_controller.dart';

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  CurrentyConvertController controller = CurrentyConvertController();

  @override
  void initState() {
    super.initState();
    fetchRates();
    controller.moneyController.addListener(updateConvertedValue);
  }

  Future fetchRates() async {
    controller.currencyRate = await controller.fetchExchangeRates(context);
    setState(() {});
  }

  
  void updateConvertedValue() {
    validateInput();
    if (controller.currencyRate != null) {
      double amount = double.tryParse(controller.moneyController.text) ?? 0.0;
      double convertedAmount = amount * ((controller.currencyRate?.rates[controller.targetCurrency]) ?? 1.0);
      controller.convertedValue = NumberFormat.currency(symbol: controller.targetCurrency == 'EUR' ? '€' : '\$').format(convertedAmount);
      setState(() {});
    }
  }

  void validateInput() {
    final input = controller.moneyController.text;
    if (input.isEmpty || double.tryParse(input) == null) {
      setState(() {
        controller.errorMessage = 'Please enter a valid number.';
      });
    } else {
      setState(() {
        controller.errorMessage = null;
      });
    }
  }

  @override
  void dispose() {
    controller.moneyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded),onPressed: () => Navigator.pop(context),),
        title: Text('Currency Converter')
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.moneyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount in ${controller.selectedCurrency}',
                errorText: controller.errorMessage,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: controller.selectedCurrency,
                  items: controller.currencyRate?.rates.keys.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (String? newValue)async {
                    controller.selectedCurrency = newValue!;
                    await fetchRates();
                    setState(() {
                      updateConvertedValue();
                    });
                  },
                ),
                Icon(Icons.navigate_next_outlined),
                DropdownButton<String>(
                  value: controller.targetCurrency,
                  items: controller.currencyRate?.rates.keys.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      controller.targetCurrency = newValue!;
                      updateConvertedValue();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Converted Value: ${controller.convertedValue}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
