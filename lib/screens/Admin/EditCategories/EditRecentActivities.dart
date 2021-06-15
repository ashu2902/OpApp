import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EditRecentActivities extends StatefulWidget {
  @override
  _EditRecentActivitiesState createState() => _EditRecentActivitiesState();
}

class _EditRecentActivitiesState extends State<EditRecentActivities> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  List<UploadTask> uploadedTasks = <UploadTask>[];

  List<File> selectedFiles = <
      File>[]; //creating a list of files that are stored temporarily to be uploaded later

  uploadFileToStorage(File file) {
    UploadTask task = _firebaseStorage
        .ref()
        .child("images/RecentActivities/${DateTime.now().toString()}")
        .putFile(file);
    return task;
  }

  var desc = '';
  var editDesc = '';
  TextEditingController highlightController = TextEditingController();
  TextEditingController editRecentActDescriptionController =
      TextEditingController();

  writeImageUrlToFireStore(
    imageUrl,
    desc,
  ) {
    desc = highlightController.text;
    _firebaseFirestore
        .collection("RecentActivities")
        .add({"url": imageUrl, "desc": desc}).whenComplete(
            () => print("$imageUrl is saved in Firestore. $desc"));
  }

  saveImageUrlToFirebase(UploadTask task) {
    task.snapshotEvents.listen((snapShot) {
      if (snapShot.state == TaskState.success) {
        snapShot.ref
            .getDownloadURL()
            .then((imageUrl) => writeImageUrlToFireStore(imageUrl, desc));
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
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Recent Activities'),
      ),
      resizeToAvoidBottomInset: true,
      body: StreamBuilder(
        stream: _firebaseFirestore.collection('RecentActivities').snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasError
              ? Container(
                  height: _height,
                  child: Text('error'),
                )
              : snapshot.hasData
                  ? Container(
                      height: _height,
                      child: Stack(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            height: _height / 1.35,
                            child: ListView.builder(
                              shrinkWrap: true,
                              clipBehavior: Clip.hardEdge,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                var doc = snapshot.data.docs[index].data();
                                var img = snapshot.data.docs[index].data();

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: _height / 6,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 8,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: _width / 9,
                                              child: Center(
                                                child: IconButton(
                                                    constraints:
                                                        BoxConstraints.expand(),
                                                    iconSize: 24,
                                                    icon: Icon(Icons.edit),
                                                    onPressed: () {
                                                      editRecentActDescriptionController
                                                          .text = doc['desc'];
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            Dialog(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    _width / 2,
                                                                child:
                                                                    TextField(
                                                                  onEditingComplete:
                                                                      () {
                                                                    editDesc =
                                                                        editRecentActDescriptionController
                                                                            .text;
                                                                  },
                                                                  controller:
                                                                      editRecentActDescriptionController,
                                                                  obscureText:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        UnderlineInputBorder(),
                                                                    hintText:
                                                                        'Enter Description',
                                                                  ),
                                                                ),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  snapshot
                                                                      .data
                                                                      .docs[
                                                                          index]
                                                                      .reference
                                                                      .update({
                                                                    "desc":
                                                                        editRecentActDescriptionController
                                                                            .text
                                                                  }).whenComplete(
                                                                    () => Navigator
                                                                        .pop(
                                                                            context),
                                                                  );
                                                                },
                                                                child: Text(
                                                                    'Edit Description'),
                                                              ),
                                                              Container(
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    snapshot
                                                                        .data
                                                                        .docs[
                                                                            index]
                                                                        .reference
                                                                        .delete()
                                                                        .whenComplete(
                                                                          () =>
                                                                              Navigator.pop(context),
                                                                        );
                                                                  },
                                                                  child: Text(
                                                                      'Delete'),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                            Container(
                                              width: _width / 2.2,
                                              child: SingleChildScrollView(
                                                child: ListTile(
                                                  title: Text(
                                                    doc["desc"],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: _width / 3.5,
                                              child: Center(
                                                child: Image.network(
                                                  img['url'],
                                                  fit: BoxFit.fill,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned.directional(
                          textDirection: TextDirection.ltr,
                          start: _width / 4,
                          width: _width / 2,
                          height: _height / 15,
                          bottom: 20,
                          child: ElevatedButton(
                            child: Text(
                              'Add Highlight',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: _width / 2,
                                      height: _height / 20,
                                      child: TextField(
                                        onEditingComplete: () {
                                          desc = highlightController.text;
                                        },
                                        controller: highlightController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText: 'Enter Description',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: ElevatedButton(
                                        child: Text('Add Highlight'),
                                        onPressed: () {
                                          selectFileToUpload();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        value: 5,
                        semanticsLabel: 'Loading',
                      ),
                    );
        },
      ),
    );
  }
}