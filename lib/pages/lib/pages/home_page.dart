import 'package:flutter/material.dart';
import 'package:flutter_app_go_voyage/pages/lib/pages/historique.dart';
import 'search_flights_page.dart';
import 'historique.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _servicesController = PageController();
  int _currentServicePage = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: scaffoldBg,

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  Text(
                    "GO TRAVEL",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const SearchFlightsPage(startWithHotel: false),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[700]),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Où voulez-vous aller ?",
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.grey[700],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 120,
              child: PageView(
                controller: _servicesController,
                onPageChanged: (i) {
                  setState(() => _currentServicePage = i);
                },
                children: [
                  _serviceCard("Réservation de Vols", Icons.flight_takeoff, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SearchFlightsPage(startWithHotel: false),
                      ),
                    );
                  }),
                  _serviceCard("Réservation d'Hôtels", Icons.hotel, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SearchFlightsPage(startWithHotel: true),
                      ),
                    );
                  }),
                  _serviceCard(
                    "Visa & Documentation",
                    Icons.assignment_rounded,
                    () {},
                  ),
                  _serviceCard(
                    "Assurance Voyage",
                    Icons.health_and_safety,
                    () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentServicePage == index ? 14 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentServicePage == index
                        ? const Color(0xFF265F6A)
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Destinations populaires",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Icon(Icons.arrow_forward_ios, size: 18),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 230,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _destinationCard(
                    "Caire",
                    "Égypte",
                    700,
                    "assets/images/caire.png",
                  ),
                  _destinationCard(
                    "Oran",
                    "Algérie",
                    650,
                    "assets/images/oran.png",
                  ),
                  _destinationCard(
                    "Alger",
                    "Algérie",
                    620,
                    "assets/images/Algiers.png",
                  ),
                  _destinationCard(
                    "Paris",
                    "France",
                    950,
                    "assets/images/paris.png",
                  ),
                  _destinationCard(
                    "Santorini",
                    "Grèce",
                    500,
                    "assets/images/santorini.png",
                  ),
                  _destinationCard(
                    "Toronto",
                    "Canada",
                    850,
                    "assets/images/toronto.jpg",
                  ),
                  _destinationCard(
                    "Sharm El Sheikh",
                    "Égypte",
                    680,
                    "assets/images/SharmElSheikh.jpg",
                  ),
                  _destinationCard(
                    "Dubai",
                    "Émirats Arabes Unis",
                    800,
                    "assets/images/dubai.png",
                  ),
                  _destinationCard(
                    "Guangzhou",
                    "Chine",
                    900,
                    "assets/images/guangzhou.jpg",
                  ),
                  _destinationCard(
                    "Sousse",
                    "Tunisie",
                    550,
                    "assets/images/sousse.jpg",
                  ),
                  _destinationCard(
                    "Tunis",
                    "Tunisie",
                    580,
                    "assets/images/tunisia.jpg",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 28,

        onTap: (index) {
          switch (index) {
            case 0:
              break;

            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const SearchFlightsPage(startWithHotel: false),
                ),
              );
              break;

            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HistoriquePage()),
              );
              break;

            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
              break;
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Icon(Icons.home_outlined),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Icon(Icons.search),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Icon(Icons.shopping_bag_outlined),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Icon(Icons.person_outline),
            ),
            label: "",
          ),
        ],
      ),
    );
  }

  Widget _serviceCard(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(width: 12.5),
            Icon(icon, size: 46, color: const Color(0xFF265F6A)),
          ],
        ),
      ),
    );
  }

  // DESTINATION CARD
  Widget _destinationCard(
    String city,
    String country,
    int price,
    String image,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DestinationDetailsPage(
              city: city,
              country: country,
              price: price,
              image: image,
            ),
          ),
        );
      },
      child: Container(
        width: 148,
        margin: const EdgeInsets.only(right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                width: 148,
                height: 148,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              city,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
            Text(
              country,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "\$$price",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
//  PAGE DE DÉTAILS
// ------------------------------------------------------------
class DestinationDetailsPage extends StatelessWidget {
  final String city;
  final String country;
  final int price;
  final String image;

  const DestinationDetailsPage({
    super.key,
    required this.city,
    required this.country,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$city, $country",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF265F6A),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                image,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              city,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            Text(
              country,
              style: const TextStyle(fontSize: 18, color: Colors.black54),
            ),

            const SizedBox(height: 15),

            Text(
              "Prix moyen du voyage : \$$price CAD",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF265F6A),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),
            Text(
              _getDescription(city),
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),

            const SizedBox(height: 25),

            const Text(
              "Activités populaires",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 15),

            _activity(Icons.beach_access, "Plages & détente"),
            _activity(Icons.directions_boat, "Excursions en bateau"),
            _activity(Icons.restaurant, "Cuisine locale"),
            _activity(Icons.photo_camera, "Sites touristiques"),
          ],
        ),
      ),
    );
  }

  Widget _activity(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF265F6A), size: 28),
          const SizedBox(width: 16),
          Text(title, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
//  DESCRIPTION AUTOMATIQUE
// ------------------------------------------------------------
String _getDescription(String city) {
  switch (city) {
    case "Caire":
      return "Le Caire est une ville historique fascinante, célèbre pour les pyramides de Gizeh, le Nil et ses marchés traditionnels.";
    case "Oran":
      return "Oran, la ville du raï, combine plages méditerranéennes, gastronomie et une ambiance vivante et chaleureuse.";
    case "Alger":
      return "Alger, la blanche, offre sa baie mythique, une Casbah classée et un mélange unique d’architecture ottomane et coloniale.";
    case "Paris":
      return "Paris, la ville lumière, est connue pour la Tour Eiffel, les musées, la mode et sa gastronomie raffinée.";
    case "Santorini":
      return "Santorini offre des vues magnifiques, des maisons blanches iconiques et des couchers de soleil célèbres.";
    case "Toronto":
      return "Toronto est une ville moderne, multiculuturelle, vibrante, avec des gratte-ciels et un bord de lac magnifique.";
    default:
      return "Une destination magnifique avec des activités variées, de la culture, de la gastronomie et des paysages uniques.";
  }
}
