import 'dart:async' show Future;
import 'dart:developer' show log;
import 'dart:io' show Directory, Platform;

import 'package:flutter/material.dart' show BuildContext, MaterialPageRoute, Navigator, Widget;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:permission_handler/permission_handler.dart' as permission_handler;
import 'package:printing/printing.dart' show Printing;
import 'package:url_launcher/url_launcher.dart' show LaunchMode, launchUrl;

/// Helper function for opening URLs.
Future<void> openURLInBrowser(String url) async {
  try {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } catch (e) {
    throw Exception('Cannot launch $url');
  }
}

/// Helper function for navigating to different views.
void navigate(BuildContext context, Widget Function(BuildContext) builder) {
  Navigator.push(
    context,
    MaterialPageRoute<Widget>(builder: builder),
  );
}

/// Helper function for getting the download folder path of the device.
Future<String?> getDownloadPath() async {
  Directory? directory;

  if (await permission_handler.Permission.storage.request().isGranted) {
    try {
      if (Platform.isIOS) {
        directory = await path_provider.getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!directory.existsSync()) {
          directory = await path_provider.getExternalStorageDirectory();
        }
      }
    } catch (error, stackTrace) {
      log('ERROR', error: error, stackTrace: stackTrace);
    }
  }

  return directory?.path;
}

/// Helper function for checking for storage permission.
Future<dynamic> getStoragePermission() async {
  final permission = await permission_handler.Permission.storage.request();

  if (permission.isGranted) {
    return true;
  } else if (permission.isPermanentlyDenied) {
    await permission_handler.openAppSettings();
  } else if (permission.isDenied) {
    return false;
  }
}

/// Helper function for printing PDFs.
Future<void> printPdf(String url) async {
  final response = await http.get(Uri.parse(url));

  await Printing.layoutPdf(onLayout: (_) => response.bodyBytes);
}

/// Helper function for getting the cache folder path of the device.
Future<String?> getCacheDirectory() async {
  final directory = await path_provider.getTemporaryDirectory();
  return directory.path;
}
