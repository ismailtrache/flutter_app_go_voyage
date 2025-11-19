import 'package:flutter/material.dart';

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  bool _showUpcoming = true; // true = À venir, false = Passés
  String _searchQuery = '';

  // ---- Données mock (tu pourras brancher sur ton backend plus tard) ----
  final List<_TripItem> _upcomingTrips = const [
    _TripItem(
      title: 'Vol vers Paris...',
      subtitle: '15 Mai · (YYZ) - (CDG)',
      type: TripType.flight,
    ),
    _TripItem(
      title: 'Vol vers Montreal...',
      subtitle: '28 Jul · (YYZ) - (YUL)',
      type: TripType.flight,
    ),
    _TripItem(
      title: 'Hotel à Paris...',
      subtitle: '15 Mai · Four Seasons - George V',
      type: TripType.hotel,
    ),
  ];

  final List<_TripItem> _pastTrips = const [
    _TripItem(
      title: 'Vol vers Rome...',
      subtitle: '10 Jan · (YYZ) - (FCO)',
      type: TripType.flight,
    ),
    _TripItem(
      title: 'Hotel à Rome...',
      subtitle: '10 Jan · Hassler Roma',
      type: TripType.hotel,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF265F6A);
    final Color bgSecondary = const Color(0xFFF5F5F5);

    // Liste filtrée selon l’onglet + la recherche
    final List<_TripItem> visibleTrips = (_showUpcoming ? _upcomingTrips : _pastTrips)
        .where(
          (t) =>
              t.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              t.subtitle.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Mes voyages',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===================== Onglets À venir / Passés =====================
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: bgSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _showUpcoming = true);
                      },
                      child: _SegmentTab(
                        label: 'À venir',
                        isSelected: _showUpcoming,
                        selectedColor: primary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _showUpcoming = false);
                      },
                      child: _SegmentTab(
                        label: 'Passés',
                        isSelected: !_showUpcoming,
                        selectedColor: primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ======================== Barre de recherche ========================
            Container(
              decoration: BoxDecoration(
                color: bgSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[700]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'rechercher ...',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(fontSize: 16),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ======================= Liste des voyages ==========================
            Expanded(
              child: visibleTrips.isEmpty
                  ? Center(
                      child: Text(
                        _showUpcoming
                            ? 'Aucun voyage à venir.'
                            : 'Aucun voyage passé.',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: visibleTrips.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final trip = visibleTrips[index];
                        return _TripCard(
                          item: trip,
                          bgColor: bgSecondary,
                          primary: primary,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // ====================== Bottom Navigation Bar ===========================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // par ex. 2 = onglet "bag" / voyages
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }
}

// ===================================================================
//  MODELE DE DONNÉE
// ===================================================================

enum TripType { flight, hotel }

class _TripItem {
  final String title;
  final String subtitle;
  final TripType type;

  const _TripItem({
    required this.title,
    required this.subtitle,
    required this.type,
  });
}

// ===================================================================
//  WIDGET : Onglet segmenté
// ===================================================================

class _SegmentTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color selectedColor;

  const _SegmentTab({
    required this.label,
    required this.isSelected,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? selectedColor : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ===================================================================
//  WIDGET : Carte d’un voyage (vol / hôtel)
// ===================================================================

class _TripCard extends StatelessWidget {
  final _TripItem item;
  final Color bgColor;
  final Color primary;

  const _TripCard({
    required this.item,
    required this.bgColor,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (item.type) {
      case TripType.flight:
        icon = Icons.flight_takeoff;
        break;
      case TripType.hotel:
        icon = Icons.hotel;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Texte
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Color(0xFF828282),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            icon,
            size: 24,
            color: primary,
          ),
        ],
      ),
    );
  }
}
