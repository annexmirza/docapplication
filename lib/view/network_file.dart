import 'package:docapplication/view/local_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_view/flutter_file_view.dart';

///
/// @Describe: 网络链接视图
///
/// @Author: LiWeNHuI
/// @Date: 2021/9/29
///

class NetworkFileViewerPage extends StatefulWidget {
  final String downloadUrl;
  final String downloadPath;

  const NetworkFileViewerPage({
    Key? key,
    required this.downloadUrl,
    required this.downloadPath,
  }) : super(key: key);

  @override
  _NetworkFileViewerPageState createState() => _NetworkFileViewerPageState();
}

class _NetworkFileViewerPageState extends State<NetworkFileViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: NetworkFileViewer(
        downloadUrl: widget.downloadUrl,
        downloadPath: widget.downloadPath,
        onViewPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (ctx) {
              return LocalFileViewerPage(filePath: widget.downloadPath);
            },
          ));
        },
      ),
    );
  }
}
