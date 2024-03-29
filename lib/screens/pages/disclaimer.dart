import 'package:YSDirectory/screens/pages/ContactUs.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  const Disclaimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Disclaimers',
          style: TextStyle(
              fontFamily: 'GentiumPlus',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please read this disclaimer carefully before using the app.',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'GentiumPlus',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Our goal is not only to make salon discovery easier and quicker but also to encourage more women to confidently visit salons, addressing concerns such as past bad experiences or anxiety about calling salons.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'While our focus lies in addressing the needs of individuals wearing the Hijab or with curly afro hair, we understand the importance of catering to a diverse audience. Our app welcomes everyone, including children, men, and those with straight or wavy hair.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'This app provides you with the nature of the salon, location, whether it is Hijabi friendly, services included and their speciality. Please do conduct more research if required.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'The salons listed are not recommendations or in order of best to worst. Just a list of salon options within the U.K.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'We have included as much information on the services provided such as pricing and/or extra details and/or duration of the services. All information is from the salon’s website and Instagram page.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'When you decide to book at any of the salons below, please let them know when you are booking that you require privacy as you wear the Hijab. As some salons would need to know beforehand, there are salons that will ask you if you wear the Hijab during the booking process online.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Always check their website or Instagram page for their policies before booking an appointment.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Please note that some of the salons listed also have male hairstylists and/or male clients. Some of these salons are also Hijabi Friendly and are of this nature (meaning the salon may be Hijabi friendly but have male clients/hairstylists too). The salons have made it clear how they provide privacy when they have male clients and/or hairstylists in the salon at the same time. You can find this information at the end of each page of the salons that relate to this.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'There are salons that provide a service to Men and Children. This will be stated in the description of the salon.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'There are some salons that are not Hijabi friendly and have been noted under those salons. Some salons have mentioned that they are considering having this privacy soon, we have also mentioned this in the description of the salons that apply.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Please note that you may come across salons that are NOT Hijabi friendly, however they may offer services that other customers may benefit from.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Most of the curl specialists’ salons do not offer services such as Relaxer and Perms as well as heat(straighteners and curling thongs).',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'There are salons listed below that DO provide services such as relaxer, silk press, heat and perms but also cater to natural hair and offer other natural hair services.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Just a side note that the salons that are Hijabi friendly are for those women who wear Hijab and need privacy. This is inclusion and what we need – you may still go to these salons if you do not need this privacy.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We look forward to expanding this list to other countries around the world. If you have any salon suggestions, or points you'll like to raise please contact us:",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  width: 230,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactUs(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orengy,
                    ),
                    child: const Text(
                      "Contact us",
                      style: TextStyle(
                        fontFamily: 'GentiumPlus',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
