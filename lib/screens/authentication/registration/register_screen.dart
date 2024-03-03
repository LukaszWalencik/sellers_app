import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellers_app/screens/home_screen.dart';
import 'package:sellers_app/widgets/custom_text_field.dart';
import 'package:sellers_app/widgets/error_dialog.dart';
import 'package:sellers_app/widgets/loading_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  Position? position;
  List<Placemark>? placeMarks;
  String sellerImageUrl = '';
  String completeAdress = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  Future<void> formValidation() async {
    if (imageXFile == null) {
      showDialog(
        context: context,
        builder: (context) => const ErrorDialog(
          message: 'Please select an image.',
        ),
      );
    } else {
      if (passwordController.text == confirmPasswordController.text) {
        if (nameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            confirmPasswordController.text.isNotEmpty &&
            phoneController.text.isNotEmpty &&
            locationController.text.isNotEmpty) {
          showDialog(
            context: context,
            builder: (context) => const LoadingDialog(
              message: 'Register Account',
            ),
          );
          String filename = nameController.text +
              DateTime.now().millisecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance
              .ref()
              .child('Sellers')
              .child(filename);
          fStorage.UploadTask uploadTask =
              reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            sellerImageUrl = url;
            authenticateSellerAndSignUp();
          });
//uploading data
        } else {
          showDialog(
            context: context,
            builder: (context) => const ErrorDialog(
              message:
                  'Please write the complete required info for registration',
            ),
          );
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => const ErrorDialog(
                  message: 'Password do not match',
                ));
      }
    }
  }

  void authenticateSellerAndSignUp() async {
    User? currentUser;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError(
      (error) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(
            message: error.message.toString(),
          ),
        );
      },
    );
    if (currentUser != null) {
      saveDataToFirestore(currentUser!).then(
        (value) => Navigator.pop(context),
      );
      Route newRoute = MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
      Navigator.pushReplacement(context, newRoute);
    }
  }

  Future<void> saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection('sellers').doc(currentUser.uid).set({
      'sellerUID': currentUser.uid,
      'sellerEmail': currentUser.email,
      'sellerName': nameController.text.trim(),
      'sellerAvatarURL': sellerImageUrl,
      'sellerPassword': passwordController.text.trim(),
      'sellerPhone': phoneController.text.trim(),
      'sellerAdress': completeAdress,
      'sellerStatus': 'aproved',
      'sellerEarnings': 0,
      'sellerLat': position!.latitude,
      'sellerLon': position!.longitude,
    });

    //save data localy

    SharedPreferences? sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString('uid', currentUser.uid);
    await sharedPreferences.setString(
      'sellerName',
      nameController.text.trim(),
    );
    await sharedPreferences.setString('sellerAvatarURL', sellerImageUrl);
  }

  getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.always) {
      Position newPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      position = newPosition;

      placeMarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      Placemark pMarks = placeMarks![0];
      String completeAdress =
          '${pMarks.subThoroughfare}, ${pMarks.thoroughfare}, ${pMarks.subLocality}, ${pMarks.locality}, ${pMarks.subAdministrativeArea}, ${pMarks.administrativeArea}, ${pMarks.postalCode}, ${pMarks.country}';
      print(completeAdress);
      locationController.text = completeAdress;
    }
    if (permission == LocationPermission.whileInUse) {
      Position newPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      position = newPosition;

      placeMarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      Placemark pMarks = placeMarks![0];
      String completeAdress =
          '${pMarks.subThoroughfare}, ${pMarks.thoroughfare}, ${pMarks.subLocality}, ${pMarks.locality}, ${pMarks.subAdministrativeArea}, ${pMarks.administrativeArea}, ${pMarks.postalCode}, ${pMarks.country}';
      print(completeAdress);
      locationController.text = completeAdress;
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Not Available');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10),
            InkWell(
              onTap: () => getImage(),
              child: CircleAvatar(
                radius: width * 0.15,
                backgroundColor: Colors.white,
                backgroundImage: imageXFile == null
                    ? null
                    : FileImage(
                        File(imageXFile!.path),
                      ),
                child: imageXFile == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        size: width * 0.15,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    icon: Icons.person,
                    controller: nameController,
                    hintText: 'Name',
                    isObscure: false,
                  ),
                  CustomTextField(
                    icon: Icons.email,
                    controller: emailController,
                    hintText: 'Email',
                    isObscure: false,
                  ),
                  CustomTextField(
                    icon: Icons.lock,
                    controller: passwordController,
                    hintText: 'Password',
                    isObscure: true,
                  ),
                  CustomTextField(
                    icon: Icons.lock,
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    isObscure: true,
                  ),
                  CustomTextField(
                    icon: Icons.phone,
                    controller: phoneController,
                    hintText: 'Phone',
                    isObscure: false,
                  ),
                  CustomTextField(
                    icon: Icons.my_location,
                    controller: locationController,
                    hintText: 'Cafe/Restaurant Adress',
                    isObscure: false,
                    enable: false,
                  ),
                  Container(
                    width: 400,
                    height: 40,
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      onPressed: () => getCurrentLocation(),
                      icon: const Icon(
                        Icons.location_on,
                        color: Colors.green,
                      ),
                      label: const Text(
                        'Get my current location',
                        style: TextStyle(color: Colors.green),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => formValidation(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
