import 'package:YSDirectory/firestore/cloudfirestore_methods.dart';
import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ContactUs extends StatelessWidget {
  final UserDetailsModel? user;
  ContactUs({Key? key, this.user}) : super(key: key);

  TextEditingController body = TextEditingController();

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: brown,
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void onSubmitFeedback(BuildContext context) async {
    if (user == null) {
      print("no user found");
      // Handle the case when user is null
      // Show an error message or handle the situation appropriately
      return;
    }
    String subject = 'User Feedback'; // Get the subject from the form input
    String userEmail =
        user!.emailAddress; // Get the user's email from the UserDetailsModel
    String message = body.text; // Get the feedback message from the form input
    //DateTime timestamp = DateTime.now(); // Get the current timestamp

    try {
      await CloudFirestoreClass().uploadFeedbackToDatabase(
        subject: subject,
        emailAddress: userEmail,
        message: message,
        //timestamp: timestamp,
      );

      // Feedback uploaded successfully, show a success message or navigate to another screen
      showSnackBar(context, 'Feedback submitted successfully!');
    } catch (e) {
      // Handle any errors that occur during the upload process
      print("Error uploading feedback: $e");
      // Show an error message to the user or handle the error appropriately
      showSnackBar(context, 'Error submitting feedback. Please try again.');
    }
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
              fontWeight: FontWeight.bold),
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
                    'images/instagram.png',
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
                      path: 'Yoursalondirectory@gmail.com',
                    );
                    final String _emailLaunchString =
                        Uri.encodeFull(_emailLaunchUri.toString());
                    await launch(_emailLaunchString);
                  },
                  child: Image.asset(
                    'images/emailb.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    final Uri _emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'Yoursalondirectory@gmail.com',
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
            child: Text('Feedback, questions, partnership opportunities...',
                style: TextStyle(fontFamily: 'GentiumPlus')),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CupertinoTextField(
              controller: body,
              placeholder: 'Enter text',
              padding: EdgeInsets.all(20),
              style: TextStyle(fontFamily: 'GentiumPlus'),
              cursorColor: orengy,
              expands: true,
              maxLines: null,
            ),
          ),
          Container(
            child: ElevatedButton(
                onPressed: () {
                  onSubmitFeedback(
                    context,
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: orengy),
                child: Text(
                  "Send to YSDirectory",
                  style: TextStyle(fontFamily: 'GentiumPlus'),
                )),
          ),
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
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
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
