import 'package:flutter/material.dart';
import 'package:rentoptions/util/toast_util.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(BuildContext context, String url) async {
  if (url.isNotEmpty) {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showShortToast(context, 'Could not launch');
    }
  } else {
    showShortToast(context, 'No URL provided for this apartment');
  }
}
