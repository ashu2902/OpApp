import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EditVideoGallery extends StatefulWidget {
  @override
  _EditVideoGalleryState createState() => _EditVideoGalleryState();
}

class _EditVideoGalleryState extends State<EditVideoGallery> {
  var date = '';
  var editdate = '';
  var title = '';
  var edittitle = '';
  var videoUrl = '';
  var editvideoUrl = '';

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  List<UploadTask> uploadedTasks = <UploadTask>[];

  List<File> selectedFiles = <
      File>[]; //creating a list of files that are stored temporarily to be uploaded later

  uploadFileToStorage(File file) {
    UploadTask task = _firebaseStorage
        .ref()
        .child("videos/VideoGallery/${DateTime.now().toString()}")
        .putFile(file);
    return task;
  }

  TextEditingController initiativeController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  TextEditingController editdateriptionController = TextEditingController();
  TextEditingController edittitleController = TextEditingController();
  TextEditingController videoUrlController = TextEditingController();
  TextEditingController editvideoUrlController = TextEditingController();

  writeImageUrlToFireStore(imageUrl, date, title) {
    date = initiativeController.text;
    videoUrl = videoUrlController.text;
    title = titleController.text;
    _firebaseFirestore.collection("VideoGallery").add({
      "img": imageUrl,
      "date": date,
      "title": title,
      "url": videoUrl
    }).whenComplete(() => print("$imageUrl is saved in Firestore. $date"));
  }

  saveImageUrlToFirebase(UploadTask task) {
    task.snapshotEvents.listen((snapShot) {
      if (snapShot.state == TaskState.success) {
        snapShot.ref.getDownloadURL().then(
            (imageUrl) => writeImageUrlToFireStore(imageUrl, date, title));
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
        title: Text('Edit Video Gallery'),
      ),
      resizeToAvoidBottomInset: true,
      body: StreamBuilder(
        stream: _firebaseFirestore.collection('VideoGallery').snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasError
              ? Container(
                  child: Text('error'),
                )
              : snapshot.hasData
                  ? Container(
                      height: _height,
                      child: Stack(
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
                                  var doc = snapshot.data.docs[index];
                                  var img = snapshot.data.docs[index];

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
                                              Container(
                                                width: _width / 9,
                                                child: Center(
                                                  child: IconButton(
                                                    constraints:
                                                        BoxConstraints.expand(),
                                                    icon: Icon(Icons.edit),
                                                    onPressed: () {
                                                      editdateriptionController
                                                          .text = doc['date'];
                                                      edittitleController.text =
                                                          doc['title'];
                                                      editvideoUrlController
                                                          .text = doc["url"];
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
                                                                    editdate =
                                                                        editdateriptionController
                                                                            .text;
                                                                  },
                                                                  controller:
                                                                      editdateriptionController,
                                                                  obscureText:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        UnderlineInputBorder(),
                                                                    hintText:
                                                                        'Enter Date',
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width:
                                                                    _width / 2,
                                                                child:
                                                                    TextField(
                                                                  onEditingComplete:
                                                                      () {
                                                                    edittitle =
                                                                        edittitleController
                                                                            .text;
                                                                  },
                                                                  controller:
                                                                      edittitleController,
                                                                  obscureText:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        UnderlineInputBorder(),
                                                                    hintText:
                                                                        'Enter title',
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width:
                                                                    _width / 2,
                                                                child:
                                                                    TextField(
                                                                  onEditingComplete:
                                                                      () {
                                                                    editvideoUrl =
                                                                        editvideoUrlController
                                                                            .text;
                                                                  },
                                                                  controller:
                                                                      editvideoUrlController,
                                                                  obscureText:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        UnderlineInputBorder(),
                                                                    hintText:
                                                                        'Enter Video URL',
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
                                                                      .update(
                                                                    {
                                                                      "date": editdateriptionController
                                                                          .text,
                                                                      "title":
                                                                          edittitleController
                                                                              .text,
                                                                      "url": editvideoUrlController
                                                                          .text
                                                                    },
                                                                  ).whenComplete(
                                                                    () => Navigator
                                                                        .pop(
                                                                            context),
                                                                  );
                                                                },
                                                                child: Text(
                                                                    'Edit'),
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
                                                                        .whenComplete(() =>
                                                                            Navigator.pop(context));
                                                                  },
                                                                  child: Text(
                                                                      'Delete'),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: _width / 3,
                                                child: Text(
                                                  doc["title"],
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              Container(
                                                child: Center(
                                                  child: Image.network(
                                                    img['img'],
                                                    height: _height / 8,
                                                    width: _height / 6,
                                                    fit: BoxFit.fill,
                                                    alignment:
                                                        Alignment.topRight,
                                                    loadingBuilder: (BuildContext
                                                            context,
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
                                'Add Video',
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Container(
                                    height: _height / 4,
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
                                              date = initiativeController.text;
                                            },
                                            controller: initiativeController,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              hintText: 'Enter the date',
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: _width / 2,
                                          height: _height / 20,
                                          child: TextField(
                                            onEditingComplete: () {
                                              date = titleController.text;
                                            },
                                            controller: titleController,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              hintText: 'Enter the title',
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: _width / 2,
                                          height: _height / 20,
                                          child: TextField(
                                            onEditingComplete: () {
                                              date = videoUrlController.text;
                                            },
                                            controller: videoUrlController,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              hintText: 'Enter Video URL',
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: ElevatedButton(
                                            child: Text('Select Image and add'),
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
                      ),
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
