import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChangeLogPage extends StatefulWidget {
  final String changelogAssetsPath;

  const ChangeLogPage({Key key, @required this.changelogAssetsPath})
      : super(key: key);

  @override
  _ChangeLogPageState createState() => _ChangeLogPageState();
}

class _ChangeLogPageState extends State<ChangeLogPage> {
  String _changelog = "";

  @override
  void initState() {
    rootBundle.loadString(widget.changelogAssetsPath).then((data) {
      setState(() {
        _changelog = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // todo convert to strings here so it's internationalized
    return Scaffold(
      appBar: AppBar(
        title: Text("Changelog"),
      ),
      body: _changelog.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Markdown(
              data: _changelog,
            ),
    );
  }
}
