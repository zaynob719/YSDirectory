import 'package:YSDirectory/screens/pages/home_screen.dart';
import 'package:YSDirectory/screens/sign_in_screen/sign_in_screen.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/widgets/custom_main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/generated/assets.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

bool isLoading = false;

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

void _launchEmail(String email) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
    query: encodeQueryParameters(<String, String>{
      'subject': 'No verification email received',
      'body':
          'I have not received any verification email. These are my registration details (name and email address) to help with the investigation',
    }),
  );
  launchUrl(emailLaunchUri);
  // final String emailLaunchString = Uri.encodeFull(emailLaunchUri.toString());
  // _launchURL(emailLaunchString);
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/emailVerification.jpeg"),
                fit: BoxFit.cover)),
        child: Container(
          margin: const EdgeInsets.only(top: 115, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Verify your email address',
                style: TextStyle(
                  fontFamily: 'GentiumPlus',
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Open your email and tap the verification link that we've sent you. Once you've done that, come back and tap Continue.",
                style: TextStyle(
                  fontFamily: 'GentiumPlus',
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 400),
              Padding(
                padding: const EdgeInsets.only(right: 80.0, left: 80),
                child: CustomMainButton(
                  color: orengy,
                  isLoading: isLoading,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                    );
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(right: 80.0, left: 80),
                child: CustomMainButton(
                  color: tagColor,
                  isLoading: isLoading,
                  onPressed: () {
                    _launchEmail("yoursalondirectory@gmail.com");
                  },
                  child: const Text(
                    'No email? Get in touch',
                    style: TextStyle(
                        fontFamily: 'GentiumPlus',
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
