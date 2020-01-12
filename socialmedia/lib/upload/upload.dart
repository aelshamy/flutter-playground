import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialmedia/common/widgets/progress.dart';
import 'package:socialmedia/model/user.dart';
import 'package:uuid/uuid.dart';

class Upload extends StatefulWidget {
  final User currentUser;

  const Upload({Key key, this.currentUser}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File image;
  bool isUploading = false;
  String postId = Uuid().v4();
  TextEditingController locationController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return image == null ? buildSplashScreen(context) : buildUploadForm();
  }

  buildSplashScreen(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          'assets/images/upload.svg',
          height: 200,
        ),
        SizedBox(height: 40),
        RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Upload Image',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          color: Colors.deepPurple,
          onPressed: () {
            selectImage(context);
          },
        )
      ],
    );
  }

  selectImage(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Create Post'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text("Photo with Camera"),
                onPressed: handleTakePhoto,
              ),
              SimpleDialogOption(
                child: Text("Image from gallary"),
                onPressed: handlePhotoFromGallary,
              ),
              SimpleDialogOption(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  handleTakePhoto() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {
      image = file;
    });
  }

  handlePhotoFromGallary() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {
      image = file;
    });
  }

  buildUploadForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: clearImage,
        ),
        title: Text(
          'Caption Text',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Post",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            onPressed: isUploading ? null : () => createPost(),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          isUploading ? LinearProgress() : SizedBox(),
          SizedBox(height: 10),
          Container(
            height: 220,
            width: MediaQuery.of(context).size.width * .8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(image),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(widget.currentUser.photoUrl),
            ),
            title: Container(
              width: 250,
              child: TextField(
                controller: captionController,
                decoration: InputDecoration(
                  hintText: "Write a caption...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.pin_drop,
              color: Colors.orange,
              size: 35,
            ),
            title: Container(
              width: 250,
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: "Where was this photo taken?",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            width: 200,
            height: 100,
            alignment: Alignment.center,
            child: RaisedButton.icon(
              label: Text(
                'Use Current Location',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.blue,
              onPressed: getUserLocation,
              icon: Icon(
                Icons.my_location,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  void clearImage() {
    setState(() {
      image = null;
      isUploading = false;
    });
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(image.readAsBytesSync());
    final compressedImageFile = File('$path/image_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      image = compressedImageFile;
    });
  }

  void createPost() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    final String mediaUrl = await uploadImage(image);
    createPostInFireStore(
      mediaUrl: mediaUrl,
      location: locationController.text,
      description: captionController.text,
    );
    captionController.clear();
    locationController.clear();
    setState(() {
      image = null;
      isUploading = false;
      postId = Uuid().v4();
    });
  }

  uploadImage(File imageFile) async {
    // final StorageUploadTask uploadTask = storageRef.child("post_$postId.jpg").putFile(imageFile);
    // final StorageTaskSnapshot uploadSnapshot = await uploadTask.onComplete;
    // final String downloadUrl = await uploadSnapshot.ref.getDownloadURL();
    // return downloadUrl;
  }

  void createPostInFireStore({String mediaUrl, String location, String description}) {
    // postRef.document(widget.currentUser.id).collection("userPosts").document(postId).setData({
    //   "postId": postId,
    //   "owner": widget.currentUser.id,
    //   "username": widget.currentUser.username,
    //   "mediaUrl": mediaUrl,
    //   "description": description,
    //   "location": location,
    //   "timestamp": DateTime.now(),
    //   "likes": {}
    // });
  }

  void getUserLocation() async {
    final Position position =
        await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    final placemark = placemarks[0];

    String completeAddress =
        '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality} ${placemark.locality}, ${placemark.subAdministrativeArea},${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';

    print(completeAddress);

    String formatedAddress = '${placemark.locality}, ${placemark.country}';
    locationController.text = formatedAddress;
  }
}
