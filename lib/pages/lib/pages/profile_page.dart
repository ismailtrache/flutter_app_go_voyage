import 'dart:io';

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'search_flights_page.dart';
import 'historique.dart';
import 'edit_profile_page.dart';
import 'change_password_page.dart'; // ✅ IMPORT pour la page mot de passe

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color primary = const Color(0xFF265F6A);

  String _userName = "John Doe";
  String _userEmail = "john.doe@email.com";
  String _userPhone = "+1 514 000 0000";
  String _userCountry = "Canada";
  String? _userImagePath;

  ImageProvider<Object>? _avatarImage() {
    if (_userImagePath == null) return null;
    final file = File(_userImagePath!);
    if (!file.existsSync()) return null;
    return FileImage(file);
  }

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

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            // ===================== PHOTO + NOM =====================
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: const Color(0xFFE0E0E0),
                    backgroundImage: _avatarImage(),
                    child: _userImagePath == null
                        ? const Icon(
                            Icons.person,
                            size: 48,
                            color: Color(0xFF9E9E9E),
                          )
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _userName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _userEmail,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ===================== SECTION COMPTE =====================
            _sectionTitle("Compte"),
            _profileTile(
              icon: Icons.edit,
              title: "Modifier le profil",
              onTap: () async {
                final result = await Navigator.push<Map<String, dynamic>>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfilePage(
                      initialName: _userName,
                      initialEmail: _userEmail,
                      initialPhone: _userPhone,
                      initialCountry: _userCountry,
                      initialImagePath: _userImagePath,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    _userName = result['name'] ?? _userName;
                    _userEmail = result['email'] ?? _userEmail;
                    _userPhone = result['phone'] ?? _userPhone;
                    _userCountry = result['country'] ?? _userCountry;
                    if (result.containsKey('imagePath')) {
                      _userImagePath = result['imagePath'] as String?;
                    }
                  });
                }
              },
              primary: primary,
            ),
            _profileTile(
              icon: Icons.lock_outline,
              title: "Changer le mot de passe",
              // ✅ Maintenant ça ouvre la vraie page de changement de mot de passe
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>   ChangePasswordPage(),
                  ),
                );
              },
              primary: primary,
            ),

            const SizedBox(height: 24),

            // ===================== SECTION PRÉFÉRENCES =====================
            _sectionTitle("Préférences"),
            _profileTile(
              icon: Icons.favorite_border,
              title: "Favoris",
              onTap: () => _soon(context),
              primary: primary,
            ),
            _profileTile(
              icon: Icons.language,
              title: "Langue",
              onTap: () => _soon(context),
              primary: primary,
            ),
            _profileTile(
              icon: Icons.settings_outlined,
              title: "Paramètres",
              onTap: () => _soon(context),
              primary: primary,
            ),

            const SizedBox(height: 24),

            // ===================== SECTION AUTRES =====================
            _sectionTitle("Autres"),
            _profileTile(
              icon: Icons.help_outline,
              title: "Aide & support",
              onTap: () => _soon(context),
              primary: primary,
            ),
            _profileTile(
              icon: Icons.logout,
              title: "Se déconnecter",
              textColor: Colors.red,
              onTap: () => _soon(context),
              primary: primary,
            ),
          ],
        ),
      ),

      // ===================== NAVIGATION BAS =====================
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 28,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
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
                MaterialPageRoute(builder: (_) => const HistoriquePage()),
              );
              break;
            case 3:
              // déjà sur Profil
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

  // ===================== WIDGETS =====================

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _profileTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color primary,
    Color? textColor,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: textColor ?? primary),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: textColor ?? Colors.black,
            ),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }

  void _soon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Fonctionnalité à venir")),
    );
  }
}
