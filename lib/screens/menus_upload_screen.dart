import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellers_app/screens/home_screen.dart';

class MenusUploadScreen extends StatefulWidget {
  const MenusUploadScreen({super.key});

  @override
  State<MenusUploadScreen> createState() => _MenusUploadScreenState();
}

class _MenusUploadScreenState extends State<MenusUploadScreen> {
  XFile? imageXFile;
  final ImagePicker imagePicker = ImagePicker();
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
          'Add New Menu',
          style: TextStyle(fontSize: 30, fontFamily: 'Lobster'),
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
                'Add New Menu',
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
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SimpleDialogOption(
              onPressed: pickImageFromGallery,
              child: const Text(
                'Capture with Camera',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SimpleDialogOption(
              child: const Text(
                'Capture with Camera',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  pickImageWithCamera() {}
  pickImageFromGallery() {}

  @override
  Widget build(BuildContext context) {
    return defaultScreen();
  }
}
