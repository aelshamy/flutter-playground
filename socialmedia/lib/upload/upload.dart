import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/auth/bloc/bloc.dart';
import 'package:socialmedia/common/widgets/progress.dart';
import 'package:socialmedia/model/user.dart';
import 'package:socialmedia/upload/bloc/upload_state.dart';

import 'bloc/bloc.dart';
import 'bloc/upload_bloc.dart';

class Upload extends StatelessWidget {
  bool isUploading = false;

  TextEditingController locationController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadBloc, UploadState>(
      builder: (BuildContext context, UploadState state) {
        if (state is UploadInitial) {
          return _buildUploadInitial(context);
        }
        return _buildUploadForm(context, (state as UploadPhotoSelected).image);
      },
    );
  }

  Widget _buildUploadInitial(BuildContext context) {
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
            _showSelectImageDialog(context);
          },
        )
      ],
    );
  }

  Future<void> _showSelectImageDialog(BuildContext context) async {
    UploadBloc uploadBloc = BlocProvider.of<UploadBloc>(context);
    return await showDialog<void>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Create Post'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("Photo with Camera"),
              onPressed: () {
                Navigator.pop(context);
                uploadBloc.add(SelectPhoto(source: ImageSource.camera));
              },
            ),
            SimpleDialogOption(
              child: Text("Image from gallary"),
              onPressed: () {
                Navigator.pop(context);
                uploadBloc.add(SelectPhoto(source: ImageSource.gallery));
              },
            ),
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUploadForm(BuildContext context, File image) {
    UploadBloc uploadBloc = BlocProvider.of<UploadBloc>(context);
    User user = (BlocProvider.of<AuthBloc>(context).state as Authenticated).user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => uploadBloc.add(CancelUpload()),
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
                fontSize: 16,
              ),
            ),
            onPressed: isUploading
                ? null
                : () {
                    captionController.clear();
                    locationController.clear();
                    uploadBloc.add(
                      CreatePost(
                        image: image,
                        user: user,
                        description: captionController.text,
                        location: locationController.text,
                      ),
                    );
                  },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          (uploadBloc.state as UploadPhotoSelected).isLoading ? LinearProgress() : SizedBox(),
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
              backgroundImage: CachedNetworkImageProvider(user.photoUrl),
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

  void getUserLocation() async {
    final Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    final placemark = placemarks[0];

    // String completeAddress =
    //     '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality} ${placemark.locality}, ${placemark.subAdministrativeArea},${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';

    String formatedAddress = '${placemark.locality}, ${placemark.country}';
    locationController.text = formatedAddress;
  }
}
