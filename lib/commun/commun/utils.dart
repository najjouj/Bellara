import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

FirebaseStorage _storage = FirebaseStorage.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
ImagePicker _pickerImage = ImagePicker();
//String uid = _auth.currentUser!.uid;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
String currentuserUID = FirebaseAuth.instance.currentUser!.uid;
//UserModel? currentuser;

//
/* 
if (isTypeLink)
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: double.infinity,
                                      child: AnyLinkPreview(
                                        link: widget.post.link!,
                                        displayDirection:
                                            UIDirection.uiDirectionHorizontal,
                                      ),*/
//pick image from gallery
//pick image file
Future<FilePickerResult?> pickImage() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image);

  return image;
}

//pick pdf
Future<FilePickerResult?> pickpdf() async {
  final pdfFile = await FilePicker.platform.pickFiles(type: FileType.any);

  return pdfFile;
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  final File? image;
  final ImagePicker picker = ImagePicker();
  try {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      return image;
    }
  } catch (e) {
    print('image picker erroooor');
    print(e.toString());
  }
  return null;
}

Future<List<File?>> pickImagesFromGallery(BuildContext context) async {
  File? image;
  List<File?> images = [];
  //final List<File?> images;
  final ImagePicker picker = ImagePicker();
  try {
    final List<XFile> pickedImages = await picker.pickMultiImage();
    for (int i = 0; i <= pickedImages.length; i++) {
      image = File(pickedImages[i].path);
      images.insert(i, image);
    }
  } catch (e) {
    print('image picker erroooor');
    print(e.toString());
  }
  return images;
}

Future<List<String>> saveimagesFiles(String path, String id,
    List<File?> imgesfile, List<Uint8List?> webimgesfile) async {
  List<String> filesUrl = [];
  String fileUrl;

  try {
    if (kIsWeb) {
      for (int i = 0; i <= webimgesfile.length; i++) {
        Reference ref =
            FirebaseStorage.instance.ref().child(path).child(id).child('img$i');
        UploadTask tsk;
        tsk = ref.putData(webimgesfile[i]!);
        final snap = await tsk;
        fileUrl = await snap.ref.getDownloadURL();
        filesUrl.add(fileUrl);
      }
    } else {
      for (int i = 0; i <= imgesfile.length; i++) {
        Reference ref =
            FirebaseStorage.instance.ref().child(path).child(id).child('img$i');
        UploadTask tsk;
        tsk = ref.putFile(imgesfile[i]!);
        final snap = await tsk;
        fileUrl = await snap.ref.getDownloadURL();
        filesUrl.add(fileUrl);
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return filesUrl;
}

Future<String> saveimageFiles(
    String path, String id, File? imgfile, Uint8List? webimgfile) async {
  String fileUrl;

  try {
    Reference ref = FirebaseStorage.instance.ref().child(path).child(id);
    UploadTask tsk;
    if (kIsWeb) {
      tsk = ref.putData(webimgfile!);
    } else {
      tsk = ref.putFile(imgfile!);
    }

    final snap = await tsk;
    fileUrl = await snap.ref.getDownloadURL();
    return fileUrl;
  } catch (e) {
    print(e.toString());
    return 'failure';
  }
}

Future<String> savePdfFileME(
    String niv, String mat, String filname, File? pdfFile) async {
  String fileUrl;

  try {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('supports du cours')
        .child("ministere d'education")
        .child(niv)
        .child(mat)
        .child(filname);
    UploadTask tsk;

    tsk = ref.putFile(pdfFile!);

    final snap = await tsk;
    fileUrl = await snap.ref.getDownloadURL();
    return fileUrl;
  } catch (e) {
    print(e.toString());
    return 'failure';
  }
}

//pick image from camera

Future<File?> pickImagefromcamera() async {
  File? photo;
  ImagePicker picker = ImagePicker();
  final camImg = await picker.pickImage(source: ImageSource.camera);

  photo = File(camImg!.path);

  return photo;
}

Future<String> stockImage(BuildContext contex, File image) async {
  var ref = _storage.ref().child('profilePic').child(_auth.currentUser!.uid);

  print('we are here');
  TaskSnapshot task = await ref.putFile(image);
  String imgUrl = await task.ref.getDownloadURL();
  print('image url iiiiiiiiiiiiiiiiiis');
  print(imgUrl);
  return imgUrl;
}
/*
Future<String> addUsertoFirestore(BuildContext context, String name,
    String imgUrl, String phonenumber) async {
  String result = '';
  UserModel user = UserModel(
      phoneNumber: phonenumber,
      groupId: [],
      name: name,
      uid: _auth.currentUser!.uid,
      profilePic: imgUrl,
      isOnline: true);
  try {
    _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .set(user.toJson());

    print('success');
    result = 'success';
    //zx = user;
    //return user;
  } catch (e) {
    print('echec adding user');
    print(e.toString());
    result = 'fail';
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => LandingScreen())),
        (route) => false);
  }
  return result;
}*/

//image picker

Future<File?> getPickedImage() async {
  File? image;
  //final uid = FirebaseAuth.instance.currentUser!.uid;
  final pickedimage = await _pickerImage.pickImage(source: ImageSource.gallery);
  print('step1');
  if (pickedimage != null) {
    image = File(pickedimage.path);
    return image;
  } else {
    print('no image selected!!');
    return null;
  }
  //get the file image
}

//image from camera

Future<String> getAndStoreimageFromCamera() async {
  final File? image;
  String imageUrl;
  try {
    final imagecam = await _pickerImage.pickImage(source: ImageSource.camera);
    if (imagecam != null) {
      //get the reference from the firebase storage

      Reference ref = storage.ref().child('profilePic').child(currentuserUID);
      //get the image file

      image = File(imagecam.path);
      // store the image
      TaskSnapshot tasksnap = await ref.putFile(image);
      imageUrl = await tasksnap.ref.getDownloadURL();
      return imageUrl;
    }
  } catch (e) {
    print(e.toString());
    return 'imageFailed';
  }
  return 'imageFailed';
}
