import 'package:YSDirectory/firestore/cloudfirestore_methods.dart';
import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/widgets/custom_main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  final UserDetailsModel? user;
  ContactUs({Key? key, this.user}) : super(key: key);

  TextEditingController body = TextEditingController();

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
        'subject': 'Feedback',
        'body': body.text,
      }),
    );
    launchUrl(emailLaunchUri);
    // final String emailLaunchString = Uri.encodeFull(emailLaunchUri.toString());
    // _launchURL(emailLaunchString);
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: brown,
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          "Contact us",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'GentiumPlus',
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Text(
              "At YSDirectory, we value your feedback and are always eager to assist you with any inquiries or partnership opportunities. Whether you have questions about our services or wish to explore collaboration possibilities, feel free to fill in the contact box below. Your input is essential to us, and we look forward to building a strong and rewarding relationship with you. We can't wait to hear from you!",
              style: TextStyle(
                fontFamily: 'GentiumPlus',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    const url =
                        "https://www.instagram.com/yoursalondirectory/?hl=en-gb";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Image.asset(
                    'images/instagramb.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    const url =
                        "https://www.instagram.com/yoursalondirectory/?hl=en-gb";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: const Text(
                    'Follow YSDirectory on Instagram!',
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    const url =
                        "https://www.tiktok.com/@yoursalondirectory?_t=8e60AisWBMx&_r=1";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Image.asset(
                    'images/tiktok.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    const url =
                        "https://www.tiktok.com/@yoursalondirectory?_t=8e60AisWBMx&_r=1";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: const Text(
                    'Follow our TikTok page!',
                    style: TextStyle(
                        fontFamily: 'GentiumPlus',
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    final Uri _emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'yoursalondirectory@gmail.com',
                    );
                    final String _emailLaunchString =
                        Uri.encodeFull(_emailLaunchUri.toString());
                    await launch(_emailLaunchString);
                  },
                  child: const Icon(Icons.markunread_rounded),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    final Uri _emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'yoursalondirectory@gmail.com',
                    );
                    final String _emailLaunchString =
                        Uri.encodeFull(_emailLaunchUri.toString());
                    await launch(_emailLaunchString);
                  },
                  child: const Text(
                    'yoursalondirectory@gmail.com',
                    style: TextStyle(
                        fontFamily: 'GentiumPlus',
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Text(
                'Feedback, questions, partnership opportunities...',
                style: TextStyle(fontFamily: 'GentiumPlus')),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CupertinoTextField(
              controller: body,
              placeholder: 'Enter text',
              padding: const EdgeInsets.all(20),
              style: const TextStyle(fontFamily: 'GentiumPlus'),
              expands: true,
              maxLines: null,
            ),
          ),
          Container(
              child: CustomMainButton(
            color: orengy,
            isLoading: false,
            onPressed: () {
              _launchEmail("yoursalondirectory@gmail.com");
            },
            child: const Text(
              "Send feedback",
              style: TextStyle(
                  fontFamily: 'GentiumPlus',
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          )),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
              onTap: () async {
                const url = "https://www.coveredncurly.com/";
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: const Text(
                "Looking for some hair after care? Check out Coverd'N'Curly's website.",
                style: TextStyle(
                    fontFamily: 'GentiumPlus',
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.7),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      )),
    );
  }
}
