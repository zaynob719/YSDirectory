Database componants 

Application componants 

Architecture 
- High level, end-to-end diagram

Developer tools 
- xcode
- firebase 
- Apple developer 
- app store

Frontend 

Backend 
- user Authentication
- Storage (images)
- Firestore Database 
- Analytics (usage)
- App check
- Cloud Messaging (notifications)
- Dynamic links (marketing, discounts)

    Sign in method
    - Email/Password
    - Goodle and 
    - Apple


Imlementation details 

Google Firebase
- Application is set up for both ios and Android 
- yoursalondirectory@gmail.com is the owner email 


Firestore Database
Documents:
- salons/name-of-salonId/reviews 

Table:
Salon
    required this.salonName,
    required this.location,
    required this.summary,
    required this.salonGeneralDescription,
    required this.id,
    required this.url,
    required this.category,
    required this.distance,
    required this.noOfRating,
    required this.rating,
    required this.website,
    required this.services,
    required this.instagram,
    required this.number,
    required this.email,
    required this.openHours,
  

- users/userId
Table 
class UserDetailsModel 
  final String? id;
  final String name;
  final String lastName;
  final String emailAddress;
  final String city;