import 'package:flutter/material.dart';

import '../controller/product_controller.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductController controller = ProductController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('List Product'),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded),onPressed: () => Navigator.pop(context),),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Total all product : ${controller.sumProduct().toStringAsFixed(2)}'),
          SizedBox(height: 20,),
          Text('Most expensive product : ${controller.mostExpensiveProduct()}'),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Check availability',
                    border: OutlineInputBorder(),
                  ),
                  controller: controller.textController,
                  onChanged: (value) {
                    controller.textController.text = value;
                    setState(() {
                      
                    });
                  },
                )
              ),
              Icon(Icons.navigate_next_rounded),
              Text('${controller.checkStock(controller.textController.text)}'),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                value: controller.kind,
                items: ['ASC','DESC'].map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (String? newValue)async {
                  setState(() {
                    controller.kind = newValue!;
                    controller.sortList(controller.kind,controller.option);
                  });
                },
              ),
              Icon(Icons.navigate_next_outlined),
              DropdownButton<String>(
                value: controller.option,
                items: ['Price','Quantity'].map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    controller.option = newValue!;
                    controller.sortList(controller.kind,controller.option);
                  });
                },
              ),
            ],
          ),
          Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: controller.sortList(controller.kind,controller.option).length,
            itemBuilder: (context, index) {
              final product =  controller.sortList(controller.kind,controller.option)[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                trailing: Text('${product.qty}'),
              );
            },
          ),
        ),
      ),
        ],
      ),
    );
  }
}