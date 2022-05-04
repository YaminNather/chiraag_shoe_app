import 'dart:io';

import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:chiraag_shoe_app/add_product_page/add_images_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

import '../injector.dart';

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
    return AppBar(
      title: const Text('Add Product'), 
      actions: <Widget>[ _buildAddButton() ]
    );
  }

  Widget _buildAddButton() {
    return IconButton(
      icon: const Icon(Icons.check), 
      onPressed: () async {
        bool areFieldsFilled = _nameFieldController.text.isNotEmpty;
        areFieldsFilled = _priceFieldController.text.isNotEmpty;
        areFieldsFilled = _descriptionFieldController.text.isNotEmpty;
        areFieldsFilled = _sizeFieldController.text.isNotEmpty;
        if(!areFieldsFilled) {
          _showErrorDialog('All fields are not filled');
          return;
        }

        if(images.isEmpty) {
          _showErrorDialog('Atleast one image is needed');
          return;
        }

        final SupabaseClient client = getIt<SupabaseClient>();
        final List<String> imageUrls = <String>[];
        for(int i = 0; i < images.length; i++) {
          final File image = images[i];
          final StorageResponse<String> uploadResponse = await client.storage.from('default').upload(
            'product_images/${path.basename(image.path)}',
            image
          );
          print("CustomLog: Image Upload Response: ${uploadResponse.data}");

          if(uploadResponse.error != null)
            throw UploadProductImageToStorageError();

          imageUrls.add(uploadResponse.data!);
        }

        final String name = _nameFieldController.text;
        final double price = double.parse(_priceFieldController.text);
        final String description = _descriptionFieldController.text;
        final int size = int.parse(_sizeFieldController.text);
        await _inventory.addProduct(name, price, description, size);
      }
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(controller: _nameFieldController, decoration: const InputDecoration(hintText: 'Name')),                                

            const SizedBox(height: 32.0),

            TextField(
              controller: _priceFieldController, 
              decoration: const InputDecoration(hintText: 'Price'),
              keyboardType: TextInputType.number
            ),

            const SizedBox(height: 32.0),

            TextField(
              controller: _descriptionFieldController, 
              decoration: const InputDecoration(hintText: 'Description'),
              keyboardType: TextInputType.multiline,
              maxLines: 3
            ),

            const SizedBox(height: 32.0),
            
            TextField(
              controller: _sizeFieldController,
              decoration: const InputDecoration(hintText: 'Size'),
              keyboardType: TextInputType.number
            ),

            const SizedBox(height: 32.0),

            _buildImagesButton()
          ]
        )
      ),
    );
  }  

  Widget _buildImagesButton() {
    return ElevatedButton(
      child: const Text('Images'), 
      onPressed: () async {
        MaterialPageRoute<List<File>> route = MaterialPageRoute<List<File>>(
          builder: (context) => AddImagesPage(images: this.images)
        );
        List<File>? images = await Navigator.of(context).push<List<File>>(route);
        if(images == null)
          return;

        setState(() => this.images = images);
      }
    );
  }

  Future<void> _showErrorDialog(String error) async {    
    await showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'), 
          content: Text(error),
          actions: <Widget>[
            ElevatedButton(child: const Text('Ok'), onPressed: () => Navigator.of(context).pop())
          ]
        );
      }
    );
  }


  List<File> images = <File>[];

  final TextEditingController _nameFieldController = TextEditingController();
  final TextEditingController _priceFieldController = TextEditingController();
  final TextEditingController _descriptionFieldController = TextEditingController();
  final TextEditingController _sizeFieldController = TextEditingController();

  final Inventory _inventory = getIt<Client>().inventory();
}  

class UploadProductImageToStorageError extends Error {}