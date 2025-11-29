import 'package:flutter/material.dart';
import 'home_page.dart';
import 'search_flights_page.dart';
import 'profile_page.dart';
import 'ticket_page.dart'; // ✅ pour afficher le billet + télécharger le PDF

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  bool _showUpcoming = true; // true = À venir, false = Passés
  String _searchQuery = '';

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

    final List<_TripItem> visibleTrips =
        (_showUpcoming ? _upcomingTrips : _pastTrips)
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
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          },
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
                      onTap: () => setState(() => _showUpcoming = true),
                      child: _SegmentTab(
                        label: 'À venir',
                        isSelected: _showUpcoming,
                        selectedColor: primary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _showUpcoming = false),
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
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                    )
                  : ListView.separated(
                      itemCount: visibleTrips.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final trip = visibleTrips[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TripDetailsPage(
                                  item: trip,
                                  isUpcoming: _showUpcoming,
                                ),
                              ),
                            );
                          },
                          child: _TripCard(
                            item: trip,
                            bgColor: bgSecondary,
                            primary: primary,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // ====================== 🔥 BOTTOM NAVIGATION UNIFORME ======================
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // Historique
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
              break; // déjà ici

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
          Icon(icon, size: 24, color: primary),
        ],
      ),
    );
  }
}

// ===================================================================
//  PAGE : DÉTAILS DU VOYAGE
// ===================================================================

class TripDetailsPage extends StatelessWidget {
  final _TripItem item;
  final bool isUpcoming;

  const TripDetailsPage({
    super.key,
    required this.item,
    required this.isUpcoming,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF265F6A);
    final bool isFlight = item.type == TripType.flight;

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
          'Détails du voyage',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carte principale avec les infos
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    isFlight ? Icons.flight_takeoff : Icons.hotel,
                    size: 32,
                    color: primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text
                        (
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF828282),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isFlight ? 'Type : Vol' : 'Type : Hôtel',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Informations supplémentaires',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Passager : John Doe\nNuméro de réservation : ABC123\nCompagnie : GO Travel Airlines',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
            ),

            const Spacer(),

            // Boutons spécifiques aux VOLS À VENIR
            if (isFlight && isUpcoming) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Modification du vol (démo UI)'),
                      ),
                    );
                  },
                  child: const Text(
                    'Modifier le vol',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF265F6A),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // ✅ Lien vers TicketPage (billet complet + PDF)
                  onPressed: () {
                    final volData = _buildVolDataForItem(item);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TicketPage(vol: volData),
                      ),
                    );
                  },
                  child: const Text(
                    'Afficher le billet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// Construit la Map<String, dynamic> attendue par TicketPage / ticket_pdf.dart
  Map<String, dynamic> _buildVolDataForItem(_TripItem item) {
    // 🔹 Tu peux adapter ces données comme tu veux, ici c’est du démo.
    if (item.subtitle.contains('(YYZ)') && item.subtitle.contains('(CDG)')) {
      // Vol vers Paris
      return {
        "flightNumber": "GT1234",
        "depart": "15 Mai 10:35",
        "arrive": "15 Mai 22:15",
        "from": "Toronto",
        "fromCode": "YYZ",
        "to": "Paris",
        "toCode": "CDG",
        "cabin": "Economy",
        "price": "750",
      };
    } else if (item.subtitle.contains('(YYZ)') && item.subtitle.contains('(YUL)')) {
      // Vol vers Montréal
      return {
        "flightNumber": "GT5678",
        "depart": "28 Jul 09:00",
        "arrive": "28 Jul 10:15",
        "from": "Toronto",
        "fromCode": "YYZ",
        "to": "Montréal",
        "toCode": "YUL",
        "cabin": "Economy",
        "price": "220",
      };
    } else if (item.subtitle.contains('(YYZ)') && item.subtitle.contains('(FCO)')) {
      // Vol vers Rome (même si vol passé, pour réutilisation éventuelle)
      return {
        "flightNumber": "GT9012",
        "depart": "10 Jan 13:20",
        "arrive": "10 Jan 23:55",
        "from": "Toronto",
        "fromCode": "YYZ",
        "to": "Rome",
        "toCode": "FCO",
        "cabin": "Economy",
        "price": "680",
      };
    }

    // Valeurs par défaut si jamais
    return {
      "flightNumber": "GT0000",
      "depart": "Date inconnue",
      "arrive": "Date inconnue",
      "from": "Ville départ",
      "fromCode": "XXX",
      "to": "Ville arrivée",
      "toCode": "YYY",
      "cabin": "Economy",
      "price": "0",
    };
  }
}