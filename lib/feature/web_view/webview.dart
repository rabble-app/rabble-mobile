import 'package:rabble/core/config/export.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  static const String routeName = '/web/:url/:title';

  final String url, title;

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
      ..loadRequest(getUrl(widget.title));
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
                    text: getTitle(widget.title),
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

  Uri getUrl(String title) {
    if (title == '1' || title == '3') {
      return Uri.parse(
          'https://rabble.notion.site/Privacy-Policy-bd014fb416b948aaaa7d8ee3d98c8f5e');
    }

    if (title == '2') {
      return Uri.parse(
          'https://rabble.notion.site/Rabble-FAQ-cd38e3e567ae499f906641ecd7632df4');
    }

    return Uri.parse('https://${widget.url}/');
  }

  getTitle(String title) {
    if (title == '1' || title == '3') {
      return kPrivacyPolicy;
    }

    if (title == '2') {
      return kFAQs;
    }

    return widget.title;
  }


}
