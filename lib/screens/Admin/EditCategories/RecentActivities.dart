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
  TextEditingController highlightController = TextEditingController();

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
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: _firebaseFirestore.collection('RecentActivities').snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasError
                ? Container(
                    child: Text('error'),
                  )
                : snapshot.hasData
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              height: _height / 1.35,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  var doc = snapshot.data.docs[index].data();
                                  var img = snapshot.data.docs[index].data();

                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
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
                                              IconButton(
                                                  icon: Icon(Icons.edit),
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          Dialog(
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              child: Expanded(
                                                                child:
                                                                    TextField(),
                                                              ),
                                                            ),
                                                            Container(
                                                              child:
                                                                  SpecificDelete(),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                              Container(
                                                width: _width / 3,
                                                child: ListTile(
                                                  title: Text(
                                                    doc["desc"],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Image.network(
                                                  img['url'],
                                                  height: _height / 8,
                                                  width: _height / 6,
                                                  fit: BoxFit.fill,
                                                  alignment: Alignment.topRight,
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
                          Positioned(
                            bottom: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: _height / 10,
                              alignment: Alignment.bottomCenter,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                elevation: 10,
                                focusElevation: 10,
                                color: Colors.blue,
                                child: Text('Add Activity'),
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                            child: Text('Add Activity'),
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
                          ),
                        ],
                      )
                    : CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class DeleteButton extends StatefulWidget {
  @override
  _DeleteButtonState createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  CollectionReference highlights =
      FirebaseFirestore.instance.collection('RecentActivities');

  deleteHighlight() async {
    QuerySnapshot snapshot = await highlights.get();
    snapshot.docs[0].reference.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
          onPressed: () => deleteHighlight(),
          child: Container(
            color: Colors.red,
            child: Text('Delete This'),
          )),
    );
  }
}

class SpecificDelete extends StatefulWidget {
  @override
  _SpecificDeleteState createState() => _SpecificDeleteState();
}

class _SpecificDeleteState extends State<SpecificDelete> {
  CollectionReference documents =
      FirebaseFirestore.instance.collection('RecentActivities');

  getData() async {
    return FirebaseFirestore.instance
        .collection('RecentActivities')
        .snapshots();
  }

  deleteData(docID) {
    FirebaseFirestore.instance
        .collection('RecentActivities/')
        .doc(docID)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
          onPressed: () {},
          child: Container(
            color: Colors.red,
            child: Text('Delete This Activity'),
          )),
    );
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  getData() async {
    return await FirebaseFirestore.instance
        .collection('RecentActivities')
        .snapshots();
  }

  deleteData(docID) {
    FirebaseFirestore.instance
        .collection('RecentActivities')
        .doc(docID)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('RecentActivities');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text("url: ${data['url']} ${data['desc']}");
        }

        return Text("loading");
      },
    );
  }
}
