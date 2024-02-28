import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellers_app/widgets/custom_text_field.dart';

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
  TextEditingController loactionController = TextEditingController();
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  Position? position;
  List<Placemark>? placeMarks;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
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
      loactionController.text = completeAdress;
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
      loactionController.text = completeAdress;
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
                    controller: loactionController,
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
                        color: Colors.white,
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
                    onPressed: () => print('Sign Up'),
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
