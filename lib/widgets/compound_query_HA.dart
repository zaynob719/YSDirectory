import 'package:YSDirectory/screens/pages/salon_detail_screen.dart';
import 'package:YSDirectory/screens/show_more.dart';
import 'package:YSDirectory/widgets/result_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompoundQueryHA extends StatefulWidget {
  final Salon? salon;
  const CompoundQueryHA({
    Key? key,
    this.salon,
  }) : super(key: key);

  @override
  State<CompoundQueryHA> createState() => _CompoundQueryHAState();
}

class _CompoundQueryHAState extends State<CompoundQueryHA> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection("salons").where("category",
          whereIn: ["Hijabi friendly", "Afro + Curly"]).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator();
        } else if (snapshot.hasData) {
          final salons = snapshot.data!.docs.map((doc) {
            return Salon.fromJson(doc.data());
          }).toList();
          if (salons.isEmpty) {
            return const Center(
              child: Text(
                'More salons coming soon!',
                style: TextStyle(fontFamily: 'GentiumPlus', fontSize: 18),
              ),
            );
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: salons.take(5).map((salon) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SalonDetailScreen(
                              salon: salon,
                              onNoOfReviewUpdated: onNoOfReviewUpdated),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 250,
                              height: 150,
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(salon.url),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  '${salon.totalRating} star',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'GentiumPlus',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          salon.salonName,
                          style: const TextStyle(
                            fontFamily: 'GentiumPlus',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          salon.location,
                          style: const TextStyle(
                            fontFamily: 'GentiumPlus',
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }
        } else {
          return const Center(
            child: Text('No salons found.'),
          );
        }
      },
    );
  }
}
