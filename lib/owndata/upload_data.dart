import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widget/rounded_button.dart';
import 'package:flutter_application_1/owndata/show_data.dart';
import 'package:image_picker/image_picker.dart';

class UploadData extends StatefulWidget {
  const UploadData({super.key});

  @override
  State<UploadData> createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  bool loading = false;
  final textController = TextEditingController();
  final uploaddataref = FirebaseDatabase.instance.ref('Own');

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }
  ////////////////////////////////////////////////////////

  ////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Data'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              TextFormField(
                controller: textController,
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.purple),
                  ),
                ),
              ),
              SizedBox(height: 20),
              /////////////////////////////////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.camera),
                      label: const Text('camera')),
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.library_add),
                      label: const Text('Gallery')),
                ],
              ),

              Container(
                width: 328,
                height: 145,
                decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                    border: Border.all(width: 1, color: Color(0xffD6CACA))),
                child: GridView.builder(
                    itemCount: imageFileList!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Image.file(
                          File(imageFileList![index].path),
                          fit: BoxFit.cover,
                          width: 92,
                          height: 92,
                        ),
                      );
                    }),
              ),
              SizedBox(height: 14),
              Padding(
                padding: EdgeInsets.only(right: 180),
                child: SizedBox(
                  width: 150,
                  height: 40,
                  child: MaterialButton(
                    child: Text(
                      'Upload',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Color(0xff3F3939),
                    onPressed: () {
                      selectImages();
                    },
                  ),
                ),
              ),
              ////////////////////////////////////////////////////////
              SizedBox(height: 20),
              RoundButton(
                  title: 'Submit Text',
                  onTap: () {
                    setState(() {
                      loading = false;
                    });
                    uploaddataref
                        .child(DateTime.now().millisecondsSinceEpoch.toString())
                        // .child('commits')
                        .set({
                      'title': textController.text.toString(),
                      'id': DateTime.now().millisecondsSinceEpoch.toString()
                    });
                  }),
              SizedBox(height: 30),
              RoundButton(
                  title: 'Check Data',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ShowOwnData()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
