import 'package:url_launcher/url_launcher.dart';

void openUrl(String url) async {
  final uri = Uri.parse(url);

  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    throw 'Cannot launch $url';
  }
}
