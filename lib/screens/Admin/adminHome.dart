import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:opbhallafoundation/screens/Admin/EditCategories/Highlights.dart';
import 'package:opbhallafoundation/screens/users/UserHome.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  //initializing firebaseFirestore and Firebase Storage here
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  List<UploadTask> uploadedTasks = <UploadTask>[];

  List<File> selectedFiles = <
      File>[]; //creating a list of files that are stored temporarily to be uploaded later

  uploadFileToStorage(File file) {
    UploadTask task = _firebaseStorage
        .ref()
        .child("images/highlights/${DateTime.now().toString()}")
        .putFile(file);
    return task;
  }

  writeImageUrlToFireStore(imageUrl) async {
    _firebaseFirestore
        .collection("highlights")
        .add({"url": imageUrl, "desc": getDesc(), "id": ""}).whenComplete(
            () => print("$imageUrl is saved in Firestore"));
  }

  getDesc() {
    TextEditingController imageController = TextEditingController();
  }

  saveImageUrlToFirebase(UploadTask task) {
    task.snapshotEvents.listen((snapShot) {
      if (snapShot.state == TaskState.success) {
        snapShot.ref
            .getDownloadURL()
            .then((imageUrl) => writeImageUrlToFireStore(imageUrl));
      }
    });
  }

  Future selectFileToUpload() async {
    try {
      FilePickerResult result = await FilePicker.platform
          .pickFiles(allowMultiple: true, type: FileType.image);

      if (result != null) {
        selectedFiles.clear();

        result.files.forEach((selectedFile) {
          File file = File(selectedFile.path);
          selectedFiles.add(file);
        });

        selectedFiles.forEach((file) {
          final UploadTask task = uploadFileToStorage(file);
          saveImageUrlToFirebase(task);

          setState(() {
            uploadedTasks.add(task);
          });
        });
      } else {
        print("User has cancelled the selection");
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
        body: Column(children: [
          uploadedTasks.length == 0
              ? Center(
                  child: Text('please select images to upload'),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return StreamBuilder<TaskSnapshot>(
                      builder: (context, snapShot) {
                        return snapShot.connectionState ==
                                ConnectionState.waiting
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
                  itemCount: uploadedTasks.length),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditHighlights(),
                  ),
                );
              },
              child: Text('Highlights'))
        ]));
  }
}
