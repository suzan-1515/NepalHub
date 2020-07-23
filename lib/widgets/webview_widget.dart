import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatefulWidget {
  final String title;
  final String url;

  const Webview({Key key, this.title, this.url}) : super(key: key);
  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
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
                        ? SizedBox.shrink()
                        : LinearProgressIndicator();
                  },
                  valueListenable: _isLoading,
                ),
                Expanded(
                  child: WebView(
                    initialUrl: widget.url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageStarted: (String url) {
                      if (url.contains(widget.url)) _isLoading.value = true;
                    },
                    onPageFinished: (String url) {
                      if (url.contains(widget.url)) _isLoading.value = false;
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
