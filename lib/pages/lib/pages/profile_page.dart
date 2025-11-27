import 'package:flutter/material.dart';
import 'home_page.dart';
import 'search_flights_page.dart';
import 'historique.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Mon profil",
          style: TextStyle(
            color: Color(0xFF265F6A),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFF265F6A),
        ),
      ),

      body: const Center(
        child: Text(
          "Page Profil (à développer)",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3, // 🔹 Ici on est sur Profil
        selectedItemColor: const Color(0xFF265F6A),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 28,

        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomePage(),
                ),
              );
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
                MaterialPageRoute(
                  builder: (_) => const HistoriquePage(),
                ),
              );
              break;

            case 3:
              // On est déjà sur la page Profil
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
}
