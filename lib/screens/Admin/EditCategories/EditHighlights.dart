import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EditHighlights extends StatefulWidget {
  @override
  _EditHighlightsState createState() => _EditHighlightsState();
}

class _EditHighlightsState extends State<EditHighlights> {
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

  var editDesc = '';
  TextEditingController editHighlightDescriptionController =
      TextEditingController();

  var desc = '';
  TextEditingController highlightController = TextEditingController();

  var title = "";
  TextEditingController titleController = TextEditingController();

  var editTitle = "";
  TextEditingController editTitleController = TextEditingController();

  writeImageUrlToFireStore(imageUrl, desc) {
    desc = highlightController.text;
    title = titleController.text;
    _firebaseFirestore
        .collection("highlights")
        .add({"url": imageUrl, "desc": desc, "title": title}).whenComplete(
            () => print("$imageUrl is saved in Firestore. $desc"));
  }

  saveImageUrlToFirebase(UploadTask task) {
    task.snapshotEvents.listen((snapShot) {
      if (snapShot.state == TaskState.success) {
        snapShot.ref
            .getDownloadURL()
            .then((imageUrl) => writeImageUrlToFireStore(imageUrl, desc))
            .catchError((error) => print("Failed to update user: $error"));
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
        title: Text('Edit Higlights'),
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 102),
        child: Container(
          height: 60,
          child: ElevatedButton(
              child: Text(
                'Add Highlight',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                highlightController.clear();
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: _width / 2,
                          height: _height / 12,
                          child: TextField(
                            onEditingComplete: () {
                              title = titleController.text;
                            },
                            controller: titleController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Title',
                            ),
                          ),
                        ),
                        Container(
                          width: _width / 2,
                          height: _height / 12,
                          child: TextField(
                            maxLines: 20,
                            onEditingComplete: () {
                              desc = highlightController.text;
                            },
                            controller: highlightController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
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
                              highlightController.clear();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
      body: StreamBuilder(
        stream: _firebaseFirestore.collection('highlights').snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasError
              ? Container(
                  child: Text('error'),
                )
              : snapshot.hasData
                  ? Container(
                      height: _height,
                      color: Colors.grey[200],
                      child: Stack(children: [
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemExtent: _height / 6,
                          shrinkWrap: true,
                          clipBehavior: Clip.hardEdge,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            var doc = snapshot.data.docs[index];
                            var img = snapshot.data.docs[index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: _width / 12,
                                    child: Center(
                                      child: IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            editTitleController.text =
                                                doc['title'];
                                            editHighlightDescriptionController
                                                .text = doc['desc'];
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: _width / 2,
                                                      child: TextField(
                                                        onEditingComplete: () {
                                                          editDesc =
                                                              editTitleController
                                                                  .text;
                                                        },
                                                        controller:
                                                            editTitleController,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          hintText:
                                                              'Enter Description',
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: _width / 2,
                                                      child: TextField(
                                                        onEditingComplete: () {
                                                          editDesc =
                                                              editHighlightDescriptionController
                                                                  .text;
                                                        },
                                                        controller:
                                                            editHighlightDescriptionController,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          hintText:
                                                              'Enter Description',
                                                        ),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        snapshot
                                                            .data
                                                            .docs[index]
                                                            .reference
                                                            .update({
                                                          "title":
                                                              editTitleController
                                                                  .text,
                                                          "desc":
                                                              editHighlightDescriptionController
                                                                  .text
                                                        }).whenComplete(
                                                          () => Navigator.pop(
                                                              context),
                                                        );
                                                      },
                                                      child: Text(
                                                          'Edit Description'),
                                                    ),
                                                    Container(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          snapshot
                                                              .data
                                                              .docs[index]
                                                              .reference
                                                              .delete()
                                                              .whenComplete(
                                                                () => Navigator
                                                                    .pop(
                                                                        context),
                                                              );
                                                        },
                                                        child: Text('Delete'),
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
                                    width: _width / 1.2,
                                    child: Card(
                                      clipBehavior: Clip.hardEdge,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(21))),
                                      elevation: 6,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            height: _height / 6,
                                            width: _width / 3,
                                            child: Center(
                                              child: Image.network(
                                                img['url'],
                                                fit: BoxFit.fill,
                                                width: _width,
                                                height: _height,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
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
                                          Column(
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    doc["title"],
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '(edit description from icon)',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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
