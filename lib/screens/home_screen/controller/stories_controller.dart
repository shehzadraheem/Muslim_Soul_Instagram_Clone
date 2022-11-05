
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as log;

import '../../../models/story.dart';

class StoriesController extends GetxController{
  RxBool isImgAvailable = false.obs;
  final _picker = ImagePicker();
  RxString selectedImagePath = ''.obs;
  RxString selectedImageSize = ''.obs;
  RxBool isLoading = false.obs;
  final _userDatBaseReference = FirebaseFirestore.instance.collection("story");

  final _storyList = RxList<Story>([]);
  List<Story> get stories => _storyList.value;


  @override
  void onInit() {
    super.onInit();
    _storyList.bindStream(getStories());
  }

  Stream<List<Story>> getStories(){
    return _userDatBaseReference
        .snapshots()
        .map((QuerySnapshot querySnapshot){

      List<Story> list = [];
      querySnapshot.docs.forEach((element) {
        list.add(Story.fromDocumentSnapshot(element));
        log.log(element.toString());
      });
      return list;
    });
  }

  Future<bool> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value = "${((File(selectedImagePath.value)).
      lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      isImgAvailable.value = true;
      return true;
    } else {
      isImgAvailable.value = false;
      return false;
    }
  }

  void createStory({required String userName, required String userUrl}){
      isLoading.value = true;
      uploadImage().then((url){
        if(url != null){
          saveDataToDb(url: url, userName: userName, userUrl: userUrl).then((value){
            isLoading.value = false;
          });
        }else{
          isLoading.value = false;
        }
      });
  }

  Future<String?> uploadImage() async{

    // most of the code is same

    File file = File(selectedImagePath.value);
    FirebaseStorage storage = FirebaseStorage.instance;

    const chars ='AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    // first we upload image
    // then we will get download url that we will save in database
    try {
      await storage
          .ref('uploads/story/${randomStr}')
          .putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      log.log(e.code.toString());
    }

    String downloadURL = await storage
        .ref('uploads/story/${randomStr}')
        .getDownloadURL();

    return downloadURL;
  }

  Future<void> saveDataToDb ({
    required String url,
    required String userName,
    required String userUrl }) async {

    User? user = FirebaseAuth.instance.currentUser;

   _userDatBaseReference.doc(user!.uid).get().then((value) async{

     // if user story already exist then only update the array
     // otherwise create an array with the new story url
     if (value.exists){
       await _userDatBaseReference.doc(user.uid).update({
         'storyUrl': FieldValue.arrayUnion([url]), // one user can have multiple stories
         // so i create an array for storing the stories
       });
     } else {
       await _userDatBaseReference.doc(user.uid).set({
         'userUid': user.uid,
         'userName': userName,
         'userUrl': userUrl,
         'storyUrl': FieldValue.arrayUnion([url]),
       });
     }

   });
  }
}