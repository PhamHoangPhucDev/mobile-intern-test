import 'package:flutter/material.dart';

import 'view/currency_convert.dart';
import 'view/missing_number.dart';
import 'view/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First App Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyAppPage(),
    );
  }
}

class MyAppPage extends StatelessWidget {
  const MyAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => CurrencyConverterScreen(),),),
            child: Text('Currency Converter')
          ),
          SizedBox(height: 20,),
          TextButton(
            onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => ProductScreen(),),),
            child: Text('Product Screen')
          ),
          SizedBox(height: 20,),
          TextButton(
            onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => MissingNumberScreen(),),),
            child: Text('Missing Number')
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
