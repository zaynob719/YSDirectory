import 'package:YSDirectory/screens/pages/ContactUs.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'FAQs',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'GentiumPlus',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Here, you’ll find answers to commonly asked questions about YSDirectory, helping you discover the perfect salon for your unique needs with ease.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GentiumPlus',
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: faqList.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(
                    faqList[index].question,
                    style: const TextStyle(
                        fontFamily: 'GentiumPlus', fontWeight: FontWeight.bold),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        faqList[index].answer,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'GentiumPlus',
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text.rich(TextSpan(children: [
                  TextSpan(
                      text:
                          "If you have any further questions or need assistance, feel free to contact us directly on ",
                      style: TextStyle(fontFamily: 'GentiumPlus')),
                  TextSpan(
                      text: "yoursalondirectory@gmail.com ",
                      style: TextStyle(
                          fontFamily: 'GentiumPlus',
                          decoration: TextDecoration.underline,
                          color: Colors.blue)),
                  TextSpan(
                      text:
                          "or by filling in the feedback form on the Contact Us page.\nWe are here to help!",
                      style: TextStyle(fontFamily: 'GentiumPlus'))
                ]))),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ContactUs()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orengy,
                  ),
                  child: const Text(
                    'Contact us',
                    style: TextStyle(fontFamily: 'GentiumPlus'),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}

final List<FAQ> faqList = [
  FAQ(
    question: 'How does Your Salon Directory work?',
    answer:
        'Your Salon Directory works by providing a comprehensive directory of salons. It gathers information about salons nature, location, services offered, pricing, pictures, and reviews. Users can search for salons based on their specific requirements and preferences. Such as Hijabi friendly salons, curl specialists etc.',
  ),
  FAQ(
    question: 'What can I expect to find in Your Salon Directory?',
    answer:
        'In Your Salon Directory, you can expect to find a variety of salon options based in the U.K. The directory includes salons specializing in different services such as curl specialists, styling specialists, color specialists, and Trichologists. It caters to a diverse range of hair types, including Curly, Coily, Kinky, Afro, and Wavy hair. You can also find salons that cater to children and men.\n\nWe have included several tabs to find specific salons for example ‘Hijabi Friendly’, this will show a list of Hijabi friendly salons. Whilst we have created these tabs, we have also added a note in the description‘Hijabi Friendly’ and mentioned if there are male clients and/or hairstylists at the salon.',
  ),
  FAQ(
    question: 'What information is provided for each salon listed?',
    answer:
        'For each salon listed in Your Salon Directory, you can find information about its nature, location, whether it is Hijabi friendly, services provided, specialty, pricing, pictures, and reviews (where available). It aims to provide comprehensive details to help users make informed decisions.',
  ),
  FAQ(
    question: 'Are the salons listed in Your Salon Directory recommended?',
    answer:
        'The salons listed in Your Salon Directory are not recommended or ranked in any particular order. The directory aims to provide a variety of salon options without endorsing or favouring any specific establishment. The purpose of the app is to provide you with a list of salons that you can choose from without the need of conducting your extensive research.',
  ),
  FAQ(
    question: 'Can I see pricing information for the salons listed?',
    answer:
        'Yes, pricing information for the salons listed in Your Salon Directory is provided. However, some salons may not have this information as they have not provided this through their platforms.',
  ),
  FAQ(
    question: 'Are there reviews available for the salons listed?',
    answer:
        'Your Salon Directory includes reviews for the salons listed, wherever available. These reviews can provide insights into the experiences of previous customers. We welcome all reviews for any salons you’ve been to for other users to read.',
  ),
  FAQ(
    question:
        'How can I provide feedback or suggest a salon to be added to the directory?',
    answer:
        'You can provide feedback or suggest a salon to be added to the directory by emailing us at yoursalondirectory@gmail.com or through the app’s feedback or contact section. This allows users to contribute their thoughts, recommendations, or suggestions.',
  ),
  FAQ(
    question:
        'Is there a cost or subscription fee to use Your Salon Directory?',
    answer:
        'Yes, there is a fee and the cost or subscription fee to use Your Salon Directory should be provided when viewing the app in the App Store on an iPhone.',
  ),
  FAQ(
    question: 'Where can I find the Your Salon Directory app?',
    answer:
        'At this moment in time, the app will be available to download on an iPhone and iPad. We look to add the Your Salon Directory app on other platforms in the future.',
  ),
  FAQ(
    question: 'Can I find salons outside of the UK?',
    answer:
        'The list of salons are based in the UK and we look to expand to other countries in the future.',
  ),
];
