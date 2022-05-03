import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class AddImagesPage extends StatefulWidget {
  const AddImagesPage({ Key? key, required this.images }) : super(key: key);

  @override
  State<AddImagesPage> createState() => _AddImagesPageState();

  final List<File> images;
}

class _AddImagesPageState extends State<AddImagesPage> {
  @override
  void initState() {
    super.initState();

    _images.addAll(widget.images);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar() => AppBar(title: const Text('Images'));

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ReorderableListView.builder(
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return _buildAddedImageTile(_images[index], key: Key(_images[index].path));
            },
            onReorder: (oldIndex, newIndex) {

            }
          )
        ),

        _buildAddButton()
      ]
    );
  }

  Widget _buildAddedImageTile(final File image, {Key? key}) {
    return ListTile(
      key: key,
      leading: Image(image: FileImage(image)),
      title: Text(path.basename(image.path)),
      trailing: IconButton(
        icon: const Icon(Icons.delete), 
        onPressed:() => setState(() => _images.remove(image))
      )
    );
  }

  Widget _buildAddButton() {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 64.0,
      width: double.infinity,      
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder())
        ),
        child: Text('Add', style: TextStyle(fontSize: theme.textTheme.headline6!.fontSize)),
        onPressed: () async {
          // final ImagePicker imagePicker = ImagePicker();
          // final XFile? pickedImageXFile = await imagePicker.pickImage(source: ImageSource.gallery);
          // if(pickedImageXFile == null)
          //   return;

          // final File pickedImage = File(pickedImageXFile.path);
          // setState(() => _images.add(pickedImage));
        }
      ),
    );
  }


  final List<File> _images = <File>[];
}