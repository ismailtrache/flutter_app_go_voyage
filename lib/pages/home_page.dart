import 'package:flutter/material.dart';
import 'search_flights_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================================
            //                     LOGO EN HAUT
            // =====================================================
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 110,
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    "GO TRAVEL",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF265F6A),
                    ),
                  ),
                  const SizedBox(height: 0),
                  const Text(
                    "SERVICES",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF265F6A),
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),

            // =====================================================
            //                BARRE DE RECHERCHE
            // =====================================================
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchFlightsPage()),
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

            const SizedBox(height: 25),

            // =====================================================
            //          CARTE "Réservation de vol"
            // =====================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Réservation de Vols",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Icon(Icons.flight, size: 40, color: Colors.black87),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =====================================================
            //                   TITRE POPULAIRES
            // =====================================================
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

            // =====================================================
            //       LISTE SCROLLABLE
            // =====================================================
            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _destinationCard(
                    city: "Caire",
                    country: "Égypte",
                    price: 700,
                    image: "assets/images/caire.png",
                  ),
                  _destinationCard(
                    city: "Oran",
                    country: "Algérie",
                    price: 650,
                    image: "assets/images/oran.png",
                  ),
                  _destinationCard(
                    city: "Paris",
                    country: "France",
                    price: 950,
                    image: "assets/images/paris.png",
                  ),
                  _destinationCard(
                    city: "Santorini",
                    country: "Grèce",
                    price: 500,
                    image: "assets/images/santorini.png",
                  ),
                  _destinationCard(
                    city: "Toronto",
                    country: "Canada",
                    price: 850,
                    image: "assets/images/toronto.jpg",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      // =====================================================
      //              BOTTOM NAVIGATION BAR
      // =====================================================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF265F6A),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }

  // =====================================================
  //             CARTE DESTINATION (Figma style)
  // =====================================================
  Widget _destinationCard({
    required String city,
    required String country,
    required int price,
    required String image,
  }) {
    return Container(
      width: 148,
      margin: const EdgeInsets.only(right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE HD
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
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
    );
  }
}
