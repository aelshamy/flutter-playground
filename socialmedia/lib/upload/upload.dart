import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/common/blocs/auth/auth_bloc.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/upload/bloc/upload_bloc.dart';

class Upload extends StatelessWidget {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController captionController = TextEditingController();

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
        Icon(
          Icons.add_a_photo,
          size: 150,
          color: Theme.of(context).accentColor.withOpacity(0.2),
        ),
        // SvgPicture.asset(
        //   'assets/images/upload.svg',
        //   height: 200,
        //   color: Theme.of(context).accentColor.withOpacity(0.3),
        //   colorBlendMode: BlendMode.color,
        // ),
        const SizedBox(height: 60),
        RaisedButton(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: Theme.of(context).accentColor,
          onPressed: () {
            _showSelectImageDialog(context);
          },
          child: const Text(
            'Upload Image',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        )
      ],
    );
  }

  Widget _buildUploadForm(BuildContext context, File image) {
    final UploadBloc uploadBloc = BlocProvider.of<UploadBloc>(context);
    final User user = (BlocProvider.of<AuthBloc>(context).state as Authenticated).user;

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
        title: const Text(
          'Caption Text',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
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
            child: Text(
              "Post",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          //TODO:update code
          // if ((uploadBloc.state as UploadPhotoSelected).isLoading)
          //   const LinearProgress(),
          const SizedBox(height: 10),
          AspectRatio(
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
          const SizedBox(height: 10),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(user.photoUrl),
            ),
            title: Container(
              width: 250,
              child: TextField(
                controller: captionController,
                decoration: const InputDecoration(
                  hintText: "Write a caption...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(),
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
                decoration: const InputDecoration(
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
              label: const Text(
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

  Future<void> _showSelectImageDialog(BuildContext context) async {
    final UploadBloc uploadBloc = BlocProvider.of<UploadBloc>(context);
    return showDialog<void>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Create Post'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                uploadBloc.add(const SelectPhoto(source: ImageSource.camera));
              },
              child: const Text("Photo with Camera"),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                uploadBloc.add(const SelectPhoto(source: ImageSource.gallery));
              },
              child: const Text("Image from gallary"),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Future<void> getUserLocation() async {
    final Position position =
        await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final List<Placemark> placemarks =
        await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    final placemark = placemarks[0];

    final formatedAddress = '${placemark.locality}, ${placemark.country}';
    locationController.text = formatedAddress;
  }
}
