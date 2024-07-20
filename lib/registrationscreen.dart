import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:globalapp/loginscreen.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'productlistscreen.dart';

class CustomerRegistrationScreen extends StatefulWidget {
  @override
  _CustomerRegistrationScreenState createState() =>
      _CustomerRegistrationScreenState();
}

class _CustomerRegistrationScreenState
    extends State<CustomerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name, contactNumber, email, address, password;
  late String pincode;
  XFile? addressProof;
  String state = '';
  String city = '';
  String extractedText = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer Registration')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Customer Name'),
              validator: (value) => value!.isEmpty ? 'Enter name' : null,
              onSaved: (value) => name = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Contact Number'),
              validator: (value) => value!.isEmpty ? 'Enter contact number' : null,
              onSaved: (value) => contactNumber = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email ID'),
              validator: (value) => value!.isEmpty ? 'Enter email' : null,
              onSaved: (value) => email = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Pin Code'),
              validator: (value) => value!.isEmpty ? 'Enter pin code' : null,
              onSaved: (value) => pincode = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'State'),
              initialValue: state,
              validator: (value) => value!.isEmpty ? 'Enter state' : null,
              onSaved: (value) => state = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'City'),
              initialValue: city,
              validator: (value) => value!.isEmpty ? 'Enter city' : null,
              onSaved: (value) => city = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
              validator: (value) => value!.isEmpty ? 'Enter address' : null,
              onSaved: (value) => address = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) => value!.isEmpty ? 'Enter password' : null,
              onSaved: (value) => password = value!,
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Upload Address Proof'),
            ),
            addressProof != null
                ? Image.file(File(addressProof!.path))
                : Text('No image selected'),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Register'),
            ),
            if (extractedText.isNotEmpty) ...[
              SizedBox(height: 16),
              Text('Extracted Text: $extractedText'),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> fetchCityAndState() async {
    if (pincode.isNotEmpty) {
      final response =
      await http.get(Uri.parse('http://www.postalpincode.in/api/pincode/$pincode'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['Status'] == 'Success') {
          setState(() {
            city = data['PostOffice'][0]['District'];
            state = data['PostOffice'][0]['State'];
          });
        } else {
          // Handle case when no data found
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Invalid Pincode')));
        }
      } else {
        // Handle error
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to fetch data')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enter Pincode')));
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        addressProof = pickedFile;
      });

      // Extract text from image
      await _extractTextFromImage();
    }
  }

  Future<void> _extractTextFromImage() async {
    if (addressProof != null) {
      final inputImage = InputImage.fromFilePath(addressProof!.path);
      final textDetector = GoogleMlKit.vision.textRecognizer();
      final RecognizedText recognizedText =
      await textDetector.processImage(inputImage);

      setState(() {
        extractedText = recognizedText.text;
        print('Extracted Text: $extractedText'); // Debug print
      });

      await textDetector.close();
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration successful')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration failed: $e')));
      }
    }
  }
}
