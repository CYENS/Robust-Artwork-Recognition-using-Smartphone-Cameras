import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:modern_art_app/utils/extensions.dart';

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
    final strings = context.strings();
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.stngs.stng.changelog),
      ),
      body: _changelog.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Markdown(
                      data: _changelog,
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(strings.button.close.customToUpperCase()),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
