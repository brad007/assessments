import 'dart:io';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'video_preview.dart';

class Gallery extends StatefulWidget {
  final ValueChanged<File> onSave;
  Gallery(this.onSave);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  String currentFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: _getAllImages(),
        builder: (context, AsyncSnapshot<List<FileSystemEntity>> snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Container();
          }
          print('${snapshot.data.length} ${snapshot.data}');
          if (snapshot.data.length == 0) {
            return Center(
              child: Text('No images found.'),
            );
          }

          return PageView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              currentFilePath = snapshot.data[index].path;
              var extension = path.extension(snapshot.data[index].path);
              if (extension == '.jpeg') {
                return Container(
                  height: 300,
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.file(
                    File(snapshot.data[index].path),
                  ),
                );
              } else {
                return VideoPreview(
                  videoPath: snapshot.data[index].path,
                );
              }
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 56.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                child: Text(
                  "SAVE",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: (){
                  widget.onSave(File(currentFilePath));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }



  Future<List<FileSystemEntity>> _getAllImages() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/media';
    final myDir = Directory(dirPath);
    List<FileSystemEntity> _images;
    _images = myDir.listSync(recursive: true, followLinks: false);
    _images.sort((a, b) {
      return b.path.compareTo(a.path);
    });
    return _images;
  }
}
