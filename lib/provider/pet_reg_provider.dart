import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PetRegistrationProvider with ChangeNotifier {
  XFile? _image;
  String? _petName;
  String? _breed;
  String? _age;
  String? _gender;

  XFile? get image => _image;
  String? get petName => _petName;
  String? get breed => _breed;
  String? get age => _age;
  String? get gender => _gender;

  void setPetName(String name) {
    _petName = name;
    notifyListeners();
  }

  void setBreed(String breed) {
    _breed = breed;
    notifyListeners();
  }

  void setAge(String age) {
    _age = age;
    notifyListeners();
  }

  void setGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = pickedFile;
      notifyListeners();
    }
  }

  void registerPet() {
    if (_petName != null &&
        _breed != null &&
        _age != null &&
        _image != null &&
        _gender != null) {
      // Perform registration logic here
      print('Pet Name: $_petName');
      print('Breed: $_breed');
      print('Age: $_age');
      print('Gender: $_gender');
      print('Image Path: ${_image?.path}');
      // For example, you might make an API call to register the pet
    } else {
      print('Please fill all the fields and upload an image');
    }
  }

  void navigateToPetRegistration(BuildContext context) {
    Navigator.pushNamed(context, '/petRegister');
  }
}
