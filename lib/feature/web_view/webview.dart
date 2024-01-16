import '../../config/export.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  static const String routeName = '/web/:url/:title';

  final String url,title;

  WebView({required this.url, required this.title});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://${widget.url}/'));
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 100.w,
            height: 11.h,
            padding: PagePadding.onlyTop(6.w),
            color: APPColors.appBlack,
            child: Stack(
              children: [
                SizedBox(
                  width: 2.w,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      NavigatorHelper().pop();
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 7.w,
                      height: 5.h,
                      margin: PagePadding.onlyLeft(1.h),
                      child: CircleAvatar(
                        backgroundColor: APPColors.appPrimaryColor,
                        child: const Icon(
                          Icons.close,
                          color: APPColors.appBlack4,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: RabbleText.subHeaderText(
                    text: widget.title,
                    color: APPColors.appPrimaryColor,
                    fontSize: 13.sp,
                    fontFamily: cGosha,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: WebViewWidget(controller: controller)),
        ],
      ),
    );
  }
}
