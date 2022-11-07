import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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

/// Helper function for getting the download folder path of the device.
Future<String?> getDownloadPath() async {
  Directory? directory;

  if (await Permission.storage.request().isGranted) {
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (error, stackTrace) {
      log('ERROR', error: error, stackTrace: stackTrace);
    }
  }

  return directory?.path;
}

Future<dynamic> getStoragePermission() async {
  final permission = await Permission.storage.request();

  if (permission.isGranted) {
    return true;
  } else if (permission.isPermanentlyDenied) {
    await openAppSettings();
  } else if (permission.isDenied) {
    return false;
  }
}
