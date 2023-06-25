import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/utils.dart';
import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  const Disclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Disclaimers',
          style: TextStyle(
              fontFamily: 'GentiumPlus',
              color: Colors.brown,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please read this disclaimer carefully before using our app.',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'GentiumPlus',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Always check their website or Instagram page for policies before booking appointment.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'I have included as much information on the services provided such as pricing and/or extra details and/or duration of the services. All information is from their website and Instagram page.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'When you decide to book at any of the salons below, please let them know in the booking that you require privacy as you wear the Hijab.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'This eBook has provided you with the nature of the salon, location, whether it is Hijabi friendly, services included and their speciality. Please do conduct more research if required.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Please note that some of the salons listed also have male hairstylists and/or male clients. Some are also Hijabi Friendly and are of this nature (meaning the salon may be Hijabi friendly but have male clients/hairstylists too). The salons have made it clear how they provide privacy when they have male clients and/or hairstylists in thesalon at the same time. You can find this information at the end of each page of the salons that relate to this.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              const Text(
                'As mentioned in the introduction there are salons that provide a service to Men and Children. This will be stated in the table of services and bullet pointed under each salon that work with these clients.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'There are some salons that are not Hijabi friendly and has been noted under those salons. Some salons have mentioned that they are considering having this privacy soon.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Majority of the curl specialists’ salons do not offer services such as Relaxer and Perms as well as heat (straighteners and curling thongs).',
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
                'The salons listed are not recommendations or in order of best to worst. Just a list of options within the U.K.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}