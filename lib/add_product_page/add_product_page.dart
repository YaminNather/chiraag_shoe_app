import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({ Key? key }) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(title: const Text('Add Product'));
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(controller: _nameFieldController, decoration: const InputDecoration(hintText: 'Name')),
          
          const SizedBox(height: 32.0),

          TextField(
            controller: _descriptionFieldController, 
            decoration: const InputDecoration(hintText: 'Description')
          ),

          const SizedBox(height: 32.0),

          TextField(controller: _priceFieldController, decoration: const InputDecoration(hintText: 'Price'))
        ]
      ),
    );
  }


  final TextEditingController _nameFieldController = TextEditingController();
  final TextEditingController _descriptionFieldController = TextEditingController();
  final TextEditingController _priceFieldController = TextEditingController();
}