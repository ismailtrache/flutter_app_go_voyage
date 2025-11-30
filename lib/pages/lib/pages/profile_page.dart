import 'package:flutter/material.dart';
import 'home_page.dart';
import 'search_flights_page.dart';
import 'historique.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Fonctionnalité à venir"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF265F6A);
    final Color sectionBg = const Color(0xFFF5F5F5);

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

      // ✅ Nouveau body : profil cohérent
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            // --------- Avatar + infos utilisateur ----------
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundColor: Color(0xFFE0E0E0),
                    // Tu pourras mettre une vraie image ici :
                    // backgroundImage: AssetImage('assets/images/profile.jpg'),
                    child: Icon(
                      Icons.person,
                      size: 48,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "John Doe",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "john.doe@email.com",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --------- Section : Compte ----------
            _ProfileSection(
              title: "Compte",
              backgroundColor: sectionBg,
              children: [
                ListTile(
                  leading: Icon(Icons.edit, color: primary),
                  title: const Text("Modifier le profil"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showSoon(context),
                ),
                ListTile(
                  leading: Icon(Icons.badge_outlined, color: primary),
                  title: const Text("Informations personnelles"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showSoon(context),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // --------- Section : Voyages ----------
            _ProfileSection(
              title: "Voyages",
              backgroundColor: sectionBg,
              children: [
                ListTile(
                  leading: Icon(Icons.flight_takeoff, color: primary),
                  title: const Text("Mes réservations"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showSoon(context),
                ),
                ListTile(
                  leading: Icon(Icons.favorite_border, color: primary),
                  title: const Text("Favoris"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showSoon(context),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // --------- Section : Préférences ----------
            _ProfileSection(
              title: "Préférences",
              backgroundColor: sectionBg,
              children: [
                ListTile(
                  leading: Icon(Icons.language, color: primary),
                  title: const Text("Langue"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text("Français"),
                      SizedBox(width: 4),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () => _showSoon(context),
                ),
                ListTile(
                  leading: Icon(Icons.notifications_none, color: primary),
                  title: const Text("Notifications"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showSoon(context),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // --------- Section : Aide & support ----------
            _ProfileSection(
              title: "Aide",
              backgroundColor: sectionBg,
              children: [
                ListTile(
                  leading: Icon(Icons.help_outline, color: primary),
                  title: const Text("Centre d’aide"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showSoon(context),
                ),
                ListTile(
                  leading: Icon(Icons.description_outlined, color: primary),
                  title: const Text("Conditions & confidentialité"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showSoon(context),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // --------- Déconnexion ----------
            TextButton.icon(
              onPressed: () {
                _showSoon(context);
              },
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              label: const Text(
                "Se déconnecter",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
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

// Petit widget pour structurer chaque bloc de la page profil
class _ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color backgroundColor;

  const _ProfileSection({
    required this.title,
    required this.children,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}