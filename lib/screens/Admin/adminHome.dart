import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/users/UserHome.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  //initializing firebaseFirestore and Firebase Storage here
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  List<UploadTask> uploadedTasks = [];

  List<File> selectedFiles =
      []; //creating a list of files that are stored temporarily to be uploaded later

  uploadToStorage(File file) {
    //to upload selected files to Firebase Storaage
    UploadTask task = _firebaseStorage
        .ref()
        .child("Images/${DateTime.now().toString()}")
        .putFile(file);

    return task;
  }

  saveImageURLtoFirestore(UploadTask task) {
    //to get image url from Firebase Storage
    task.snapshotEvents.listen((snapShot) {
      if (snapShot.state == TaskState.success) {
        snapShot.ref
            .getDownloadURL()
            .then((imageURL) => writeImgURLtoFitersore(imageURL));
      }
      print('error');
    });
  }

  writeImgURLtoFitersore(imageURL) {
    //writes the fetched url from FbStorage to Firestore
    _firebaseFirestore
        .collection("Images/")
        .add({'url': imageURL}).whenComplete(
            () => print("$imageURL is succesfully saved to Firestore"));
  }

  //func to select files to upload
  Future selectFileToUpload() async {
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.image); //to catch an exception if it happens

      if (result != null) {
        selectedFiles.clear(); //this clears the previously selected files
        //this block converts the type from "platform file" to "file object"
        result.files.forEach((selectedFile) {
          File file = File(selectedFile.path);
          selectedFiles.add(
              file); //adds the user selected files to the 'selectedFiles' list

          selectedFiles.forEach((file) {
            final UploadTask task = uploadToStorage(
                file); //lets the user see progress of uploading images
            setState(() {
              uploadedTasks.add(task);
            });
          });
        });
      } else {
        print('User has cancelled');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.photo_album),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserHomePage()));
                })
          ],
          title: Text('Admin Panel'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            selectFileToUpload();
          },
        ),
        body: uploadedTasks.length == 0
            ? Center(
                child: Text('please select images to upload'),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return StreamBuilder<TaskSnapshot>(
                    builder: (context, snapShot) {
                      return snapShot.connectionState == ConnectionState.waiting
                          ? CircularProgressIndicator()
                          : snapShot.hasError
                              ? Center(
                                  child: Text("there's an error"),
                                )
                              : snapShot.hasData
                                  ? ListTile(
                                      title: Text(
                                          "${snapShot.data.bytesTransferred}/${snapShot.data.totalBytes} ${snapShot.data.state == TaskState.success ? 'completed' : snapShot.data.state == TaskState.running ? 'In Progress' : 'Error'}"),
                                    )
                                  : Container();
                    },
                    stream: uploadedTasks[index].snapshotEvents,
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: uploadedTasks.length));
  }
}
