// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:pet_care/constants/snackbar.dart';
// import 'package:pet_care/provider/get_ownerData_provider.dart';
// import 'package:pet_care/provider/pets_provider.dart';
// import 'package:pet_care/services/firestore_service/pet_register.dart';

// class PetRegistrationProvider with ChangeNotifier {
//   XFile? _image;
//   String? _petName;
//   String? _breed;
//   String? _age;
//   String? _weight;
//   String? _gender;

//   bool _friendlyWithChildren = false;
//   bool _friendlyWithOtherPets = false;
//   bool _houseTrained = false;
//   int _walksPerDay = 1;
//   String _energyLevel = 'Low';
//   String? _feedingSchedule;
//   bool _canBeLeftAlone = false;

//   XFile? get image => _image;
//   String? get petName => _petName;
//   String? get breed => _breed;
//   String? get age => _age;
//   String? get weight => _weight;
//   String? get gender => _gender;

//   bool get friendlyWithChildren => _friendlyWithChildren;
//   bool get friendlyWithOtherPets => _friendlyWithOtherPets;
//   bool get houseTrained => _houseTrained;
//   int get walksPerDay => _walksPerDay;
//   String get energyLevel => _energyLevel;
//   String? get feedingSchedule => _feedingSchedule;
//   bool get canBeLeftAlone => _canBeLeftAlone;

//   final FireStoreService _fireStoreService = FireStoreService();

//   void setPetName(String name) {
//     _petName = name;
//     notifyListeners();
//   }

//   void setBreed(String breed) {
//     _breed = breed;
//     notifyListeners();
//   }

//   void setAge(String age) {
//     _age = age;
//     notifyListeners();
//   }

//   void setGender(String gender) {
//     _gender = gender;
//     notifyListeners();
//   }

//   void setFriendlyWithChildren(bool value) {
//     _friendlyWithChildren = value;
//     notifyListeners();
//   }

//   void setFriendlyWithOtherPets(bool value) {
//     _friendlyWithOtherPets = value;
//     notifyListeners();
//   }

//   void setHouseTrained(bool value) {
//     _houseTrained = value;
//     notifyListeners();
//   }

//   void setWalksPerDay(int value) {
//     _walksPerDay = value;
//     notifyListeners();
//   }

//   void setEnergyLevel(String value) {
//     _energyLevel = value;
//     notifyListeners();
//   }

//   void setFeedingSchedule(String schedule) {
//     _feedingSchedule = schedule;
//     notifyListeners();
//   }

//   void setCanBeLeftAlone(bool value) {
//     _canBeLeftAlone = value;
//     notifyListeners();
//   }

//   Future<void> pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       _image = pickedFile;
//       notifyListeners();
//     }
//   }

//   void clearFields() {
//     _image = null;
//     _petName = null;
//     _breed = null;
//     _age = null;
//     _weight = null;
//     _gender = null;
//     _friendlyWithChildren = false;
//     _friendlyWithOtherPets = false;
//     _houseTrained = false;
//     _walksPerDay = 1;
//     _energyLevel = 'Low';
//     _feedingSchedule = null;
//     _canBeLeftAlone = false;
//     notifyListeners();
//   }

//   void registerPet(BuildContext context) async {
//     final selectedPetType =
//         Provider.of<PetsProvider>(context, listen: false).selectedPetType;

//     final ownerEmail =
//         Provider.of<OwnerDetailsGetterProvider>(context, listen: false).email;

//         var test =Provider.of<OwnerDetailsGetterProvider>(context, listen: false).loadUserProfile();
//     print("ownerEmail IS :  $ownerEmail"   );

//     if (_petName != null &&
//         _breed != null &&
//         _age != null &&
//         _image != null &&
//         _gender != null &&
//         ownerEmail.isNotEmpty) {
//       try {
//         bool isDuplicate =
//             await _fireStoreService.isPetNameDuplicate(ownerEmail, _petName!);

//         if (isDuplicate) {
//           showSnackBar(context,
//               "Pet name already exists. Please choose a different name.");
//           return;
//         }

//         await _fireStoreService.savePetDetails(
//           ownerEmail: ownerEmail,
//           petName: _petName!,
//           breed: _breed!,
//           age: _age!,
//           gender: _gender!,
//           imagePath: _image!.path,
//           friendlyWithChildren: _friendlyWithChildren,
//           friendlyWithOtherPets: _friendlyWithOtherPets,
//           houseTrained: _houseTrained,
//           walksPerDay: _walksPerDay,
//           energyLevel: _energyLevel,
//           feedingSchedule: _feedingSchedule ?? '',
//           canBeLeftAlone: _canBeLeftAlone,
//           selectedPetType: selectedPetType ?? '',
//         );

//         showSnackBar(context, "Pet Registration Successful");
//         Navigator.pushReplacementNamed(context, '/ownerHomeScreen');
//         //clearFields();
//       } catch (e) {
//         showSnackBar(context, "Error! Something went wrong!");
//         print(
//             'Pet Name: $_petName, Breed: $_breed, Age: $_age, Gender: $_gender, Image Path: ${_image?.path}');
//         print('Error registering pet: $e');
//       }
//     } else {
//       showSnackBar(context, "Please fill all the fields and upload an image");
//       print('Please fill all the fields and upload an image');
//     }
//   }

//   void navigateToPetRegistration2(BuildContext context) {
//     Navigator.pushNamed(context, '/petRegistration2');
//   }

//   void navigateToOwnerDashboard(BuildContext context) {
//     Navigator.pushNamed(context, '/ownerHomeScreen');
//   }
// }



import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care/constants/snackbar.dart';
import 'package:pet_care/provider/owner_reg_provider.dart';
import 'package:pet_care/provider/pets_provider.dart';
import 'package:pet_care/services/firestore_service/pet_register.dart';
import 'package:provider/provider.dart';

class PetRegistrationProvider with ChangeNotifier {
  XFile? _image;
  String? _petName;
  String? _breed;
  String? _age;
  String? _weight;
  String? _gender;

  bool _friendlyWithChildren = false;
  bool _friendlyWithOtherPets = false;
  bool _houseTrained = false;
  int _walksPerDay = 1;
  String _energyLevel = 'Low';
  String? _feedingSchedule;
  bool _canBeLeftAlone = false;

  XFile? get image => _image;
  String? get petName => _petName;
  String? get breed => _breed;
  String? get age => _age;
  String? get weight => _weight;
  String? get gender => _gender;

  bool get friendlyWithChildren => _friendlyWithChildren;
  bool get friendlyWithOtherPets => _friendlyWithOtherPets;
  bool get houseTrained => _houseTrained;
  int get walksPerDay => _walksPerDay;
  String get energyLevel => _energyLevel;
  String? get feedingSchedule => _feedingSchedule;
  bool get canBeLeftAlone => _canBeLeftAlone;

  final FireStoreService _fireStoreService = FireStoreService();

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

  /* void setWeight(String age) {
    _weight = weight;
    notifyListeners();
  }*/

  void setGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  void setFriendlyWithChildren(bool value) {
    _friendlyWithChildren = value;
    notifyListeners();
  }

  void setFriendlyWithOtherPets(bool value) {
    _friendlyWithOtherPets = value;
    notifyListeners();
  }

  void setHouseTrained(bool value) {
    _houseTrained = value;
    notifyListeners();
  }

  void setWalksPerDay(int value) {
    _walksPerDay = value;
    notifyListeners();
  }

  void setEnergyLevel(String value) {
    _energyLevel = value;
    notifyListeners();
  }

  void setFeedingSchedule(String schedule) {
    _feedingSchedule = schedule;
    notifyListeners();
  }

  void setCanBeLeftAlone(bool value) {
    _canBeLeftAlone = value;
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

  void registerPet(BuildContext context) async {
    final selectedPetType =
        Provider.of<PetsProvider>(context, listen: false).selectedPetType;
    final ownerEmail =
        Provider.of<OwnerRegistrationProvider>(context, listen: false).email;

    if (_petName != null &&
        _breed != null &&
        _age != null &&
        //_weight != null &&
        _image != null &&
        _gender != null) {
      try {
        // Check if the pet name is already registered
        bool isDuplicate =
            await _fireStoreService.isPetNameDuplicate(ownerEmail, _petName!);

        if (isDuplicate) {
          showSnackBar(context,
              "Pet name already exists. Please choose a different name.");
          return;
        }

        // Save the pet details
        await _fireStoreService.savePetDetails(
          ownerEmail: ownerEmail,
          petName: _petName!,
          breed: _breed!,
          age: _age!,
          //weight: _weight!,
          gender: _gender!,
          imagePath: _image!.path,
          friendlyWithChildren: _friendlyWithChildren,
          friendlyWithOtherPets: _friendlyWithOtherPets,
          houseTrained: _houseTrained,
          walksPerDay: _walksPerDay,
          energyLevel: _energyLevel,
          feedingSchedule: _feedingSchedule ?? '',
          canBeLeftAlone: _canBeLeftAlone,
          selectedPetType: selectedPetType ?? '',
        );

        // Navigate to owner dashboard and pass pet details as arguments
        Navigator.pushReplacementNamed(
          context,
          '/ownerHomeScreen',
          arguments: {
            'petName': _petName,
            'petBreed': _breed,
            'petAge': _age,
            'imagePath': _image!.path,
          },
        );

        showSnackBar(context, "Pet Registration Successful");
      } catch (e) {
        showSnackBar(context, "Error! Something went wrong!");
        print(
            'Pet Name: $_petName, Breed: $_breed, Age: $_age, Gender: $_gender, Image Path: ${_image?.path}');

        print('Error registering pet: $e');
      }
    } else {
      showSnackBar(context, "Please fill all the fields and upload an image");
      print('Please fill all the fields and upload an image');
    }
  }

  void navigateToPetRegistration2(BuildContext context) {
    Navigator.pushNamed(context, '/petRegistration2');
  }

  void navigateToOwnerDashboard(BuildContext context) {
    Navigator.pushNamed(context, '/ownerHomeScreen');
  }
}