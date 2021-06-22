import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EditEventRegistrations extends StatefulWidget {
  @override
  _EditEventRegistrationsState createState() => _EditEventRegistrationsState();
}

class _EditEventRegistrationsState extends State<EditEventRegistrations> {
  String id;
  var eventTitle;
  var eventUrl;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  TextEditingController editTitleController = TextEditingController();
  TextEditingController editUrlController = TextEditingController();
  var editUrl;
  var editTitle;

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
        title: Text('Event Registrations'),
      ),
      body: StreamBuilder(
          stream: _firestore
              .collection('OnGoingEvents')
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
                                'OnGoing Events',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: _width / 1.2,
                                child: ListView.builder(
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
                                                      doc['title'];
                                                  editUrlController.text =
                                                      doc['link'];
                                                  showModalBottomSheet(
                                                    enableDrag: true,
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            BottomSheet(
                                                                clipBehavior:
                                                                    Clip.none,
                                                                elevation: 18,
                                                                onClosing:
                                                                    () {},
                                                                builder:
                                                                    (builder) {
                                                                  return SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 60),
                                                                          child:
                                                                              TextField(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            onEditingComplete:
                                                                                () {
                                                                              editTitle = editTitleController.text;
                                                                            },
                                                                            controller:
                                                                                editTitleController,
                                                                            obscureText:
                                                                                false,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              border: UnderlineInputBorder(),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 60),
                                                                          child:
                                                                              TextField(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            onEditingComplete:
                                                                                () {
                                                                              editUrl = editUrlController.text;
                                                                            },
                                                                            controller:
                                                                                editUrlController,
                                                                            obscureText:
                                                                                false,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              border: UnderlineInputBorder(),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 60,
                                                                              vertical: 2),
                                                                          child: ElevatedButton(
                                                                              onPressed: () {
                                                                                snapshot.data.docs[index].reference.update({
                                                                                  "title": editTitleController.text,
                                                                                  "link": editUrlController.text
                                                                                }).whenComplete(
                                                                                  () => Navigator.pop(context),
                                                                                );
                                                                                editTitleController.clear();
                                                                                editUrlController.clear();
                                                                              },
                                                                              child: Text('Edit')),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 60),
                                                                          child: ElevatedButton(
                                                                              onPressed: () {
                                                                                snapshot.data.docs[index].reference.delete().whenComplete(
                                                                                      () => Navigator.pop(context),
                                                                                    );
                                                                              },
                                                                              child: Text('Delete')),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                  );
                                                  print('tapped');
                                                }),
                                            Container(
                                              height: _height / 12,
                                              width: _width / 1.5,
                                              child: Card(
                                                child: Center(
                                                  child: Text(doc["title"]),
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
                                                          'Enter Event Title'),
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
                                                      hintText:
                                                          'Enter the Link'),
                                                  controller: urlController,
                                                  onEditingComplete: () {
                                                    eventTitle =
                                                        urlController.text;
                                                  },
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  addTitle();
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Add Event',
                                                  style:
                                                      TextStyle(fontSize: 18),
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

  openDialog(id) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 800,
          width: 600,
          child: StreamBuilder(
            stream: _firestore
                .collection('Gallery')
                .doc(id)
                .collection('photo')
                .snapshots(),
            builder: (context, snapshot) {
              final _height = MediaQuery.of(context).size.height;
              final _width = MediaQuery.of(context).size.width;

              return snapshot.hasData
                  ? SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              'Photos',
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              height: _height / 1.3,
                              width: _width / 1.5,
                              child: ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    final _height =
                                        MediaQuery.of(context).size.height;

                                    var img = snapshot.data.docs[index].data();
                                    return Container(
                                      height: _height / 6,
                                      margin:
                                          EdgeInsets.only(top: 6, bottom: 6),
                                      child: Image.network(
                                        img['url'],
                                        fit: BoxFit.fill,
                                        alignment: Alignment.topRight,
                                      ),
                                    );
                                  }),
                            ),
                            Container(
                              child: ElevatedButton(
                                  onPressed: () {
                                    print(id);
                                    selectFileToUpload(id);
                                  },
                                  child: Text('Add Images')),
                            )
                          ],
                        ),
                      ),
                    )
                  : snapshot.hasError
                      ? Container(
                          child: Text(snapshot.error),
                        )
                      : Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        );
            },
          ),
        ),
      ),
    );
  }

  List<File> selectedFiles = <File>[];
  List<UploadTask> uploadedTasks = <UploadTask>[];

  uploadFileToStorage(File file) {
    UploadTask task = _firebaseStorage
        .ref()
        .child("images/gallery/photos/${DateTime.now().toString()}")
        .putFile(file);
    return task;
  }

  saveImageUrlToFirebase(UploadTask task, id) {
    task.snapshotEvents.listen((snapShot) {
      if (snapShot.state == TaskState.success) {
        snapShot.ref
            .getDownloadURL()
            .then((imageUrl) => writeImageUrlToFireStore(imageUrl, id))
            .catchError((error) => print("Failed to update user: $error"));
      }
    });
  }

  writeImageUrlToFireStore(imageUrl, id) {
    _firestore.collection("Gallery").doc(id).collection('photo').add({
      "url": imageUrl,
    }).whenComplete(() => print("$imageUrl is saved in Firestore."));
  }

  Future selectFileToUpload(id) async {
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
          saveImageUrlToFirebase(task, id);

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
