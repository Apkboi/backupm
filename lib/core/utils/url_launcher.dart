import 'package:url_launcher/url_launcher.dart';

// Define the data types
enum LinkType {
  website,
  email,
  phoneNumber,
}

class UrlLauncher {
  /// Launch a URL if possible
  Future<void> launchURL(String urlString) async {
    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $urlString';
    }
  }

  /// Launch an email client with the given email address
  Future<void> sendEmail(String emailAddress) async {
    final mailtoUri = Uri(scheme: 'mailto', path: emailAddress);
    await launchURL(mailtoUri.toString());
  }

  /// Launch a dialer with the given phone number
  Future<void> dialPhoneNumber(String phoneNumber) async {
    final telUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchURL(telUri.toString());
  }
}
