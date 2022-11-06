import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' show LaunchMode, launchUrl;

/// Helper function for opening URLs.
void openURLInBrowser(String url) async {
  try {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } catch (e) {
    throw 'Cannot launch $url';
  }
}

/// Helper function for navigating to different views.
void navigate(BuildContext context, Widget Function(BuildContext) builder) => Navigator.push(
      context,
      MaterialPageRoute(builder: builder),
    );
