// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sellers_app/model/menus_model.dart';
import 'package:sellers_app/screens/global/global.dart';
import 'package:sellers_app/screens/home_screen.dart';
import 'package:sellers_app/widgets/error_dialog.dart';
import 'package:sellers_app/widgets/progress_bar.dart';

class ItemsUploadScreen extends StatefulWidget {
  MenusModel? menusModel;
  ItemsUploadScreen({
    Key? key,
    this.menusModel,
  }) : super(key: key);

  @override
  State<ItemsUploadScreen> createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen> {
  XFile? imageXFile;
  final ImagePicker imagePicker = ImagePicker();
  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  bool uploading = false;
  String uniqueUIDName = DateTime.now().microsecondsSinceEpoch.toString();

  defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.green,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text(
          'Add New Item',
          style: TextStyle(fontSize: 20, fontFamily: 'Lobster'),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shop_two,
              color: Colors.grey,
              size: 200,
            ),
            ElevatedButton(
              onPressed: () {
                takeImage(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: const Text(
                'Add New Item',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }

  takeImage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            'Menu Image',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
              onPressed: pickImageWithCamera,
              child: const Text(
                'Capture with Camera',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SimpleDialogOption(
              onPressed: pickImageFromGallery,
              child: const Text(
                'Select from Gallery',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SimpleDialogOption(
              child: const Text(
                'Cancel',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  pickImageWithCamera() async {
    Navigator.pop(context);
    imageXFile = await imagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 720, maxWidth: 1280);
    setState(() {
      imageXFile;
    });
  }

  pickImageFromGallery() async {
    Navigator.pop(context);
    imageXFile = await imagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 720, maxWidth: 1280);
    setState(() {
      imageXFile;
    });
  }

  itemUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.green,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text(
          'Uploading New Item',
          style: TextStyle(fontSize: 20, fontFamily: 'Lobster'),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.clear, color: Colors.white),
          onPressed: () {
            clearItemUploadForm();
          },
        ),
        actions: [
          TextButton(
            onPressed: uploading ? null : () => validateUploadForm(),
            child: const Text(
              'Add',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Varela',
                letterSpacing: 3,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          uploading == true ? linearProgess() : const Text(''),
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        File(imageXFile!.path),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: Colors.green),
          ListTile(
            leading: const Icon(
              Icons.perm_device_information,
              color: Colors.green,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: shortInfoController,
                decoration: const InputDecoration(
                  hintText: 'Info',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          const Divider(color: Colors.green),
          ListTile(
            leading: const Icon(
              Icons.title,
              color: Colors.green,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          const Divider(color: Colors.green),
          ListTile(
            leading: const Icon(
              Icons.description,
              color: Colors.green,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          const Divider(color: Colors.green),
          ListTile(
            leading: const Icon(
              Icons.money,
              color: Colors.green,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: priceController,
                decoration: const InputDecoration(
                  hintText: 'Price',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          const Divider(color: Colors.green),
        ],
      ),
    );
  }

  Future<String> uploadImage(mImageFile) async {
    storageRef.Reference reference =
        storageRef.FirebaseStorage.instance.ref().child('items');
    storageRef.UploadTask uploadTask =
        reference.child('$uniqueUIDName.jpg').putFile(mImageFile);
    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    return downloadURL;
  }

  saveInfo(String downloadURL) {
    final ref = FirebaseFirestore.instance
        .collection('sellers')
        .doc(sharedPreferences!.getString('uid'))
        .collection('menus')
        .doc(widget.menusModel!.menuID)
        .collection('items');

    ref.doc(uniqueUIDName).set({
      'itemID': uniqueUIDName,
      'menuID': widget.menusModel!.menuID,
      'sellerUID': sharedPreferences!.getString('uid'),
      'sellerName': sharedPreferences!.getString('sellerName'),
      'itemInfo': shortInfoController.text.toString(),
      'itemTitle': titleController.text.toString(),
      'description': descriptionController.text.toString(),
      'price': int.parse(priceController.text),
      'publishedDate': DateTime.now(),
      'status': 'available',
      'thumbnailUrl': downloadURL,
    }).then(
      (_) {
        final itemRef = FirebaseFirestore.instance.collection('items');

        itemRef.doc(uniqueUIDName).set(
          {
            'itemID': uniqueUIDName,
            'menuID': widget.menusModel!.menuID,
            'sellerUID': sharedPreferences!.getString('uid'),
            'sellerName': sharedPreferences!.getString('sellerName'),
            'itemInfo': shortInfoController.text.toString(),
            'itemTitle': titleController.text.toString(),
            'description': descriptionController.text.toString(),
            'price': int.parse(priceController.text),
            'publishedDate': DateTime.now(),
            'status': 'available',
            'thumbnailUrl': downloadURL,
          },
        );
      },
    );
    clearItemUploadForm();
    setState(
      () {
        uploading = false;
      },
    );
  }

  validateUploadForm() async {
    if (imageXFile != null) {
      if (shortInfoController.text.isNotEmpty &&
          titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          priceController.text.isNotEmpty) {
        setState(
          () {
            uploading = true;
          },
        );
// ulpoad image

        String downloadURL = await uploadImage(File(imageXFile!.path));
// save info to firebase
        saveInfo(downloadURL);
      } else {
        showDialog(
          context: context,
          builder: (context) => const ErrorDialog(
            message: 'Please write title and info for Menu.',
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            const ErrorDialog(message: 'Please pick an image for Menu.'),
      );
    }
  }

  clearItemUploadForm() {
    setState(
      () {
        shortInfoController.clear();
        titleController.clear();
        imageXFile = null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return imageXFile == null ? defaultScreen() : itemUploadFormScreen();
  }
}
