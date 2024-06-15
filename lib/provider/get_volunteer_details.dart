import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care/constants/snackbar.dart';
import 'package:pet_care/provider/volunteer_login_provider.dart';
import 'package:pet_care/services/firestore_service/volunteer_firestore.dart';
import 'package:provider/provider.dart';

class VolunteerDetailsGetterProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FireStoreService _fireStoreService = FireStoreService();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String _name = '';
  String _email = '';
  String _phoneNo = '';
  String? _profileImageUrl;
  File? _profileImageFile;
  bool _isDataLoaded = false;
  String _aboutMe = '';
  String? _imageUrl;
  String? _age;
  String? _occupation;

  bool get isDataLoaded => _isDataLoaded;
  String get name => _name;
  String get email => _email;
  String get phoneNo => _phoneNo;
  String? get profileImageUrl => _profileImageUrl;
  File? get profileImageFile => _profileImageFile;
  String? get aboutMe => _aboutMe;
  String? get imageUrl => _imageUrl;
  String? get age => _age;
  String? get occupation => _occupation;

  VolunteerDetailsGetterProvider() {
    loadVolunteerDetails();
  }

  Future<void> loadVolunteerDetails() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        final volunteerData =
            await _fireStoreService.getVolunteerDetails(user.uid);
        _name = volunteerData?['name'] ?? '';
        _email = volunteerData?['email'] ?? '';
        _phoneNo = volunteerData?['phoneNo'] ?? '';
        _profileImageUrl = volunteerData?['profileImageUrl'];
        _aboutMe = volunteerData?['aboutMe'];
        _age = volunteerData?['age'];
        _occupation = volunteerData?['occupation'];

        _isDataLoaded = true;
        notifyListeners();
      } catch (e) {
        print("Error loading volunteer details: $e");
      }
    } else {
      print("No user logged in.");
    }
  }

  void setPhoneNo(String phoneNo) {
    _phoneNo = phoneNo;
    notifyListeners();
  }

  void setaboutMe(String aboutMe) {
    _aboutMe = aboutMe;
    notifyListeners();
  }

  Future<void> pickProfileImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _profileImageFile = File(pickedFile.path);
      notifyListeners();
      showSnackBar(context, 'Profile Image picked successfully!');
    } else {
      showSnackBar(context, "No profile image selected!");
    }
  }

  Future<void> saveProfile(BuildContext context) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        if (_profileImageFile != null) {
          String filePath = 'volunteer/profile_images/${user.uid}.jpg';
          UploadTask uploadTask =
              _storage.ref().child(filePath).putFile(_profileImageFile!);
          TaskSnapshot taskSnapshot = await uploadTask;
          _imageUrl = await taskSnapshot.ref.getDownloadURL();

          // Update profile image URL in Firestore
          await _fireStoreService.updateVolunteerProfileImage(
              userId: user.uid, imageUrl: _imageUrl!);
        }

        final volunteerData =
            await _fireStoreService.getVolunteerDetails(user.uid);

        await _fireStoreService.saveVolunteerDetails(
          userId: user.uid,
          name: volunteerData?['name'] ?? '',
          email: volunteerData?['email'] ?? '',
          phoneNo: _phoneNo,
          age: volunteerData?['age'] ?? '', // Add age here if needed
          occupation: volunteerData?['occupation'] ??
              '', // Add occupation here if needed
          aboutMe: _aboutMe,
          prefersCat: false, // Add other preferences here if needed
          prefersDog: false,
          prefersBird: false,
          prefersRabbit: false,
          prefersOthers: false,
          providesHomeVisits: false,
          providesDogWalking: false,
          providesHouseSitting: false,
          role: 'volunteer',
          profileImageUrl: _imageUrl, // Save the profile image URL
        );

        showSnackBar(context, "Profile details saved successfully!");
      } catch (e) {
        showSnackBar(context, e.toString());
        print("Error Saving Profile: $e");
      }
    } else {
      showSnackBar(context, "No user logged in");
    }
  }

  Future<void> volunteerLogout(BuildContext context) async {
    try {
      await Provider.of<VolunteerLoginProvider>(context, listen: false)
          .volunteerLogout(context);
      showSnackBar(context, "Logout Successful!");
      clearData();
    } catch (e) {
      print("Error logging out $e");
      showSnackBar(context, "Error logging out $e");
    }
  }

  void clearData() {
    _name = '';
    _email = '';
    _phoneNo = '';
    _profileImageUrl = null;
    _aboutMe = '';
    _profileImageUrl = '';
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
