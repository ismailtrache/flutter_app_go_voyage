import 'package:flutter/material.dart';

class SearchFlightsPage extends StatelessWidget {
  const SearchFlightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // ===== LOGO + TITRE =====
            Center(
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png', height: 130),
                  const SizedBox(height: 10),
                  const Text(
                    "TRACHE TRAVEL",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF265F6A),
                    ),
                  ),
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

            // ===== ONGLET VOL / HOTEL =====
            Container(
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF265F6A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Vols",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.flight, color: Colors.white, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6D6D6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Hotels",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.bed, color: Colors.black87, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ===== LE RESTE DE L'INTERFACE =====
            const SizedBox(height: 25),

            // De
            _buildInputField(
              icon: Icons.search,
              text: "De Toronto",
              trailingIcon: Icons.edit,
            ),

            const SizedBox(height: 15),

            // A
            _buildInputField(
              icon: Icons.search,
              text: "A New york",
              trailingIcon: Icons.edit,
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    text: "Départ",
                    trailingIcon: Icons.calendar_today,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildInputField(
                    text: "Retour",
                    trailingIcon: Icons.calendar_today,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            _buildInputField(
              icon: Icons.person_outline,
              text: "2 Adultes",
              trailingIcon: Icons.keyboard_arrow_down,
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    text: "Aller-Retour",
                    trailingIcon: Icons.keyboard_arrow_down,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildInputField(
                    text: "Escales",
                    trailingIcon: Icons.keyboard_arrow_down,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Center(
              child: Container(
                width: 180,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF265F6A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Rechercher",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),

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

  Widget _buildInputField({
    IconData? icon,
    required String text,
    IconData? trailingIcon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: Colors.grey[700]),
          if (icon != null) const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
          ),
          if (trailingIcon != null) Icon(trailingIcon, color: Colors.grey[800]),
        ],
      ),
    );
  }
}
