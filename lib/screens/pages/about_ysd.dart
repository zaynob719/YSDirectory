import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutYSD extends StatefulWidget {
  const AboutYSD({Key? key}) : super(key: key);

  @override
  State<AboutYSD> createState() => _AboutYSDState();
}

class _AboutYSDState extends State<AboutYSD> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: lightBrown,
            pinned: true,
            expandedHeight: 250.0,
            floating: true,
            iconTheme: const IconThemeData(color: Colors.black),
            flexibleSpace: FlexibleSpaceBar(
              // centerTitle: true,
              // title: Text(
              //   "Your Salon Directory",
              //   style: TextStyle(
              //       fontFamily: 'GentiumPlus',
              //       color: Colors.white,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 24),
              // ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/new_logos.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text(
                    "Welcome to Your Salon Directory",
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 24,
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text(
                    "This is a platform designed to simplify the process of finding the perfect salon that caters to your unique needs. We take pride in being the middleman, offering a hassle-free approach to finding a salon that meets your requirements. We conduct extensive research, ask the right questions, and share our findings with you to make your salon search easier and more accessible.",
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text(
                    "Our directory app provides a comprehensive list of salons with detailed information on their nature, location, whether they are Hijabi-friendly, services provided, and their specialty. We also include pricing, pictures, and reviews wherever possible, giving you a better idea of what to expect from each salon.",
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text(
                    "We understand the challenges faced by those with natural hair types, such as Curly, Coily, Kinky, Afro, and Wavy hair. That's why we have made sure to include a range of salons that specialize in working with these hair types. Our directory also caters to an underrepresented group, offering a variety of options that meet the needs of women who wear the Hijab. We know how challenging it can be to find a salon that provides privacy and is shielded from non-familial adult males, and we're here to help.",
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text(
                    "We also make sure to note the services that apply to men and children on each relevant section. Please note that the salons listed are not ranked in any particular order of preference, and are simply a variety of options based in the UK that you may consider for your next visit.",
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text(
                    "At YSDirectory, we aim to make the process of finding the ideal salon as stress-free as possible. So, let us help you find a salon that meets your unique needs and removes the burden of searching for the perfect salon.",
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          'Yoursalondirectory@gmail.com',
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            ),
          ),
        ],
      ),
    );
  }
}
