import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/utils/utils.dart';
import 'package:flutter/material.dart';

class discounts extends StatelessWidget {
  const discounts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Discounts",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'GentiumPlus',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Information about hos this dicount page works. Some disclaimers e.g do not share the code, book and confirm with the stylist before going. More information about how this page will keep adding more discounts as they come so keep a look out on this page!',
                style: TextStyle(fontFamily: 'GentiumPlus'),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 100,
                  width: screenSize.width,
                  color: lightBrown,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      'Discounts coming soon!',
                      style: TextStyle(fontFamily: 'GentiumPlus'),
                    )),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 100,
                  width: screenSize.width,
                  color: lightBrown,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: Text('Discounts coming soon! ',
                            style: TextStyle(fontFamily: 'GentiumPlus'))),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 100,
                  width: screenSize.width,
                  color: lightBrown,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: Text('Discounts coming soon! ',
                            style: TextStyle(fontFamily: 'GentiumPlus'))),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 100,
                  width: screenSize.width,
                  color: lightBrown,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: Text('Discounts coming soon! ',
                            style: TextStyle(fontFamily: 'GentiumPlus'))),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 100,
                  width: screenSize.width,
                  color: lightBrown,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Discounts coming soon! ',
                          style: TextStyle(fontFamily: 'GentiumPlus')),
                    ),
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
