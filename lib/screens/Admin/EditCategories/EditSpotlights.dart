import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EditSpotlights extends StatefulWidget {
  @override
  _EditSpotlightsState createState() => _EditSpotlightsState();
}

class _EditSpotlightsState extends State<EditSpotlights> {
  String id;
  var eventTitle;
  var eventUrl;
  var date;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  TextEditingController urlController = TextEditingController();

  TextEditingController editTitleController = TextEditingController();
  TextEditingController editUrlController = TextEditingController();
  TextEditingController editDateController = TextEditingController();

  var editUrl;
  var editTitle;
  var editDate;

  addTitle() {
    eventUrl = urlController.text;
    eventTitle = titleController.text;
    _firestore
        .collection('OnGoingEvents')
        .add({"title": eventTitle, "link": eventUrl}).whenComplete(() => print(
            'Event Title is: $eventTitle \n Registration link is:$eventUrl'));
    titleController.clear();
    urlController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Spotlights'),
      ),
      body: StreamBuilder(
          stream: _firestore
              .collection('Spotlights')
              .snapshots(), //Change to ONGOING EVENTS
          builder: (context, snapshot) {
            return snapshot.hasError
                ? Container(
                    child: Text("There's an error. ${snapshot.error}"),
                  )
                : snapshot.hasData
                    ? Container(
                        height: _height,
                        width: _width,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(33.0),
                              child: Text(
                                'Spotlights',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: _width / 1,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      var doc =
                                          snapshot.data.docs[index].data();
                                      return Container(
                                        child: Row(
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.edit_outlined),
                                                onPressed: () {
                                                  //bottomSheet
                                                  editTitleController.text =
                                                      doc['Name'];
                                                  editUrlController.text =
                                                      doc['link'];
                                                  editDateController.text =
                                                      doc['Date'];
                                                  showModalBottomSheet(
                                                    enableDrag: true,
                                                    context: context,
                                                    builder: (context) =>
                                                        AnimatedPadding(
                                                      padding:
                                                          MediaQuery.of(context)
                                                              .viewInsets,
                                                      duration: const Duration(
                                                          milliseconds: 100),
                                                      child: BottomSheet(
                                                          clipBehavior:
                                                              Clip.none,
                                                          elevation: 18,
                                                          onClosing: () {},
                                                          builder: (builder) {
                                                            return SingleChildScrollView(
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            60),
                                                                    child:
                                                                        TextField(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      onEditingComplete:
                                                                          () {
                                                                        editTitle =
                                                                            editTitleController.text;
                                                                      },
                                                                      controller:
                                                                          editTitleController,
                                                                      obscureText:
                                                                          false,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            'Edit Name',
                                                                        border:
                                                                            UnderlineInputBorder(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            60),
                                                                    child:
                                                                        TextField(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      onEditingComplete:
                                                                          () {
                                                                        editTitle =
                                                                            editDateController.text;
                                                                      },
                                                                      controller:
                                                                          editDateController,
                                                                      obscureText:
                                                                          false,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            'Edit Date',
                                                                        border:
                                                                            UnderlineInputBorder(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            60),
                                                                    child:
                                                                        TextField(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      onEditingComplete:
                                                                          () {
                                                                        editUrl =
                                                                            editUrlController.text;
                                                                      },
                                                                      controller:
                                                                          editUrlController,
                                                                      obscureText:
                                                                          false,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            'Edit url',
                                                                        border:
                                                                            UnderlineInputBorder(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            60,
                                                                        vertical:
                                                                            2),
                                                                    child: ElevatedButton(
                                                                        onPressed: () {
                                                                          snapshot
                                                                              .data
                                                                              .docs[index]
                                                                              .reference
                                                                              .update({
                                                                            "Name":
                                                                                editTitleController.text,
                                                                            "Date":
                                                                                editDateController.text,
                                                                            "link":
                                                                                editUrlController.text
                                                                          }).whenComplete(
                                                                            () =>
                                                                                Navigator.pop(context),
                                                                          );
                                                                          editTitleController
                                                                              .clear();
                                                                          editUrlController
                                                                              .clear();
                                                                        },
                                                                        child: Text('Edit')),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            60),
                                                                    child: ElevatedButton(
                                                                        onPressed: () {
                                                                          snapshot
                                                                              .data
                                                                              .docs[index]
                                                                              .reference
                                                                              .delete()
                                                                              .whenComplete(
                                                                                () => Navigator.pop(context),
                                                                              );
                                                                        },
                                                                        child: Text('Delete')),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                  );
                                                  print('tapped');
                                                }),
                                            Container(
                                              height: _height / 6,
                                              width: _width / 1.2,
                                              child: Card(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Image.network(
                                                      doc['img'],
                                                      fit: BoxFit.fill,
                                                      height: _height,
                                                      width: _width / 3,
                                                    ),
                                                    Text(doc["Name"]),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                height: _height / 18,
                                child: ElevatedButton(
                                  onPressed: () {
                                    //add event dialog
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        child: Container(
                                          height: _height / 2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: _width / 2,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          'Enter Spotlight name'),
                                                  controller: titleController,
                                                  onEditingComplete: () {
                                                    eventTitle =
                                                        titleController.text;
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: _width / 2,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      hintText: 'Enter Date'),
                                                  controller: dateController,
                                                  onEditingComplete: () {
                                                    eventTitle =
                                                        dateController.text;
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: _width / 2,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          'Enter the Link'),
                                                  controller: urlController,
                                                  onEditingComplete: () {
                                                    eventTitle =
                                                        urlController.text;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    selectFileToUpload();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Select image and Add',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: Text(
                                      "Add Event",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : CircularProgressIndicator();
          }),
    );
  }

  List<File> selectedFiles = <File>[];
  List<UploadTask> uploadedTasks = <UploadTask>[];

  uploadFileToStorage(File file) {
    UploadTask task = _firebaseStorage
        .ref()
        .child("images/${DateTime.now().toString()}")
        .putFile(file);
    return task;
  }

  saveImageUrlToFirebase(UploadTask task) {
    task.snapshotEvents.listen((snapShot) {
      if (snapShot.state == TaskState.success) {
        snapShot.ref
            .getDownloadURL()
            .then((imageUrl) => writeImageUrlToFireStore(imageUrl))
            .catchError((error) => print("Failed to update user: $error"));
      }
    });
  }

  writeImageUrlToFireStore(imageUrl) {
    eventTitle = titleController.text;
    eventUrl = urlController.text;
    date = dateController.text;

    _firestore.collection("Spotlights").add({
      "Name": eventTitle,
      "Date": date,
      "link": eventUrl,
      "img": imageUrl,
    }).whenComplete(() => print("$imageUrl is saved in Firestore."));
  }

  Future selectFileToUpload() async {
    try {
      FilePickerResult result = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.image);
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
}
