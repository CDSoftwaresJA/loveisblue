import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WebView extends StatefulWidget {
  final String site;
  WebView(this.site);
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
           border: Border.all(width: 0.2),
          middle: Text(widget.site,overflow: TextOverflow.ellipsis,maxLines: 1,),
        ),
        child: webView());
  }

  webView() {
    return EasyWebView(
      src: widget.site,
      isHtml: false, 
      isMarkdown: false, 
      onLoaded: (){},
    );
  }
}
