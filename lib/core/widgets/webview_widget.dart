import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/core/utils/link_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InBuiltWebViewScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/webview';

  const InBuiltWebViewScreen({
    Key key,
  }) : super(key: key);

  @override
  _InBuiltWebViewScreenState createState() => _InBuiltWebViewScreenState();
}

class _InBuiltWebViewScreenState extends State<InBuiltWebViewScreen> {
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(true);
  WebViewController _controller;
  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InBuiltWebViewScreenArgs args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
        actions: [
          OptionsMenu(
            onShare: () {
              GetIt.I.get<ShareService>().share(
                  threadId: args.url, data: '${args.title}\n${args.url}');
            },
            onCopyLink: () {
              Clipboard.setData(ClipboardData(text: args.url))
                  .then((value) => context.showMessage('Link copied.'));
            },
            onOpenInBrowser: () {
              LinkUtils.openLink(args.url);
            },
            onRefresh: () {
              this._isLoading.value = true;
              this._controller.reload();
            },
          ),
        ],
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
                    onWebViewCreated: (controller) =>
                        this._controller = controller,
                    initialUrl: args.url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageStarted: (String url) {},
                    onPageFinished: (String url) {
                      _isLoading.value = false;
                    },
                    gestureNavigationEnabled: false,
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

class OptionsMenu extends StatelessWidget {
  final Function onShare;
  final Function onCopyLink;
  final Function onOpenInBrowser;
  final Function onRefresh;

  const OptionsMenu(
      {Key key,
      this.onShare,
      this.onCopyLink,
      this.onOpenInBrowser,
      this.onRefresh})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyText2;
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'share':
            onShare();
            break;
          case 'copy_link':
            onCopyLink();
            break;
          case 'open_browser':
            onOpenInBrowser();
            break;
          case 'refresh':
            onRefresh();
            break;
        }
      },
      itemBuilder: (context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'share',
            child: Text(
              'Share',
              style: textTheme,
            ),
          ),
          PopupMenuItem<String>(
            value: 'copy_link',
            child: Text(
              'Copy Link',
              style: textTheme,
            ),
          ),
          PopupMenuItem<String>(
            value: 'open_browser',
            child: Text(
              'Open in Browser',
              style: textTheme,
            ),
          ),
          PopupMenuItem<String>(
            value: 'refresh',
            child: Text(
              'Refresh',
              style: textTheme,
            ),
          ),
        ];
      },
    );
  }
}

class InBuiltWebViewScreenArgs {
  final String title;
  final String url;
  final Map<String, dynamic> data;

  InBuiltWebViewScreenArgs(
      {@required this.title, @required this.url, this.data});
}
