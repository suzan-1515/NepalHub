import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatefulWidget {
  final String title;
  final String url;

  const Webview({Key key, @required this.title, @required this.url})
      : super(key: key);

  static Future navigate(BuildContext context, String title, String url) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Webview(
          title: title,
          url: url,
        ),
      ),
    );
  }

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(true);
  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Builder(
          builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ValueListenableBuilder<bool>(
                  builder: (BuildContext context, bool value, Widget child) {
                    return value
                        ? LinearProgressIndicator()
                        : SizedBox.shrink();
                  },
                  valueListenable: _isLoading,
                ),
                Expanded(
                  child: WebView(
                    initialUrl: widget.url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageStarted: (String url) {},
                    onPageFinished: (String url) {
                      _isLoading.value = false;
                    },
                    gestureNavigationEnabled: true,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
