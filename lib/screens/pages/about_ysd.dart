import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/utils.dart';
import 'package:flutter/material.dart';

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
            flexibleSpace: FlexibleSpaceBar(
              //centerTitle: true,
              // title: Text(
              //   'YSDirectory',
              //   style: const TextStyle(
              //     fontFamily: 'GentiumPlus',
              //     color: Colors.brown,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 24,
              //   ),
              // ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/logo_background.png'),
                        fit: BoxFit.cover,
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
                  margin: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Welcome to Your Salon Direcotry",
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "This is a platform designed to simplify the process of finding the perfect salon that caters to your unique needs. We take pride in being the middleman, offering a hassle-free approach to finding a salon that meets your requirements. We conduct extensive research, ask the right questions, and share our findings with you to make your salon search easier and more accessible.",
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Our directory app provides a comprehensive list of salons with detailed information on their nature, location, whether they are Hijabi-friendly, services provided, and their specialty. We also include pricing, pictures, and reviews wherever possible, giving you a better idea of what to expect from each salon.",
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "We understand the challenges faced by those with natural hair types, such as Curly, Coily, Kinky, Afro, and Wavy hair. That's why we have made sure to include a range of salons that specialize in working with these hair types. Our directory also caters to an underrepresented group, offering a variety of options that meet the needs of women who wear the Hijab. We know how challenging it can be to find a salon that provides privacy and is shielded from non-familial adult males, and we're here to help.",
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "We also make sure to note the services that apply to men and children on each relevant section. Please note that the salons listed are not ranked in any particular order of preference, and are simply a variety of options based in the UK that you may consider for your next visit.",
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "At Your Salon Directory, we aim to make the process of finding the ideal salon as stress-free as possible. So, let us help you find a salon that meets your unique needs and removes the burden of searching for the perfect salon.",
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Looking for some hair after care? Check Coverd'N'Curly line of products...",
                    style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
