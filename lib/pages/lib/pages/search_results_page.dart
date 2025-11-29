import 'package:flutter/material.dart';
import 'cheapest_flight_page.dart';

class SearchResultsPage extends StatefulWidget {
  final String from;
  final String to;
  final DateTime? departDate;
  final DateTime? retourDate;
  final int adults;
  final int tripType; // 0 = Aller-Retour, 1 = Aller simple
  final int stopCount; // 0 direct, 1 = 1 escale, 2 = 2+

  const SearchResultsPage({
    super.key,
    required this.from,
    required this.to,
    required this.departDate,
    required this.retourDate,
    required this.adults,
    required this.tripType,
    required this.stopCount,
  });

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  int selectedTab = 0; // 0 = meilleur, 1 = moins cher, 2 = plus rapide

  List<Map<String, dynamic>> flights = [];

  @override
  void initState() {
    super.initState();
    flights = _buildFlights();
    _applySorting();
  }

  List<Map<String, dynamic>> _buildFlights() {
    final base = [
      {
        "airline": "Air Canada",
        "flightNumber": "AC-421",
        "cabin": "Economy",
        "price": 310,
        "duration": 4.30,
        "departTime": "08:40",
        "arrivalTime": "12:55",
        "returnDepartTime": "18:40",
        "returnArriveTime": "22:55",
        "stops": 0,
      },
      {
        "airline": "WestJet",
        "flightNumber": "WS-202",
        "cabin": "Economy",
        "price": 290,
        "duration": 4.05,
        "departTime": "11:05",
        "arrivalTime": "15:10",
        "returnDepartTime": "17:10",
        "returnArriveTime": "21:30",
        "stops": 0,
      },
      {
        "airline": "Air Transat",
        "flightNumber": "TS-310",
        "cabin": "Economy",
        "price": 330,
        "duration": 4.00,
        "departTime": "06:50",
        "arrivalTime": "10:50",
        "returnDepartTime": "21:00",
        "returnArriveTime": "01:05",
        "stops": 0,
      },
      {
        "airline": "American Airlines",
        "flightNumber": "AA-102",
        "cabin": "Business",
        "price": 350,
        "duration": 3.50,
        "departTime": "09:10",
        "arrivalTime": "12:40",
        "returnDepartTime": "17:30",
        "returnArriveTime": "21:00",
        "stops": 1,
      },
      {
        "airline": "British Airways",
        "flightNumber": "BA-215",
        "cabin": "Economy",
        "price": 280,
        "duration": 4.50,
        "departTime": "13:20",
        "arrivalTime": "17:50",
        "returnDepartTime": "16:30",
        "returnArriveTime": "21:10",
        "stops": 1,
      },
      {
        "airline": "Delta",
        "flightNumber": "DL-340",
        "cabin": "Premium Economy",
        "price": 320,
        "duration": 4.10,
        "departTime": "10:25",
        "arrivalTime": "14:35",
        "returnDepartTime": "19:15",
        "returnArriveTime": "23:20",
        "stops": 1,
      },
      {
        "airline": "United Airlines",
        "flightNumber": "UA-887",
        "cabin": "First",
        "price": 300,
        "duration": 2.45,
        "departTime": "07:55",
        "arrivalTime": "10:40",
        "returnDepartTime": "19:25",
        "returnArriveTime": "22:10",
        "stops": 2,
      },
      {
        "airline": "Lufthansa",
        "flightNumber": "LH-604",
        "cabin": "Business",
        "price": 370,
        "duration": 5.10,
        "departTime": "12:05",
        "arrivalTime": "17:15",
        "returnDepartTime": "14:50",
        "returnArriveTime": "20:05",
        "stops": 2,
      },
      {
        "airline": "Air France",
        "flightNumber": "AF-718",
        "cabin": "Economy",
        "price": 265,
        "duration": 5.30,
        "departTime": "15:40",
        "arrivalTime": "21:10",
        "returnDepartTime": "13:25",
        "returnArriveTime": "18:55",
        "stops": 2,
      },
    ];

    bool matchesStops(int s) {
      if (widget.stopCount == 0) return s == 0;
      if (widget.stopCount == 1) return s <= 1;
      return true;
    }

    String? formatDate(DateTime? d) =>
        d == null ? null : "${d.day}/${d.month}/${d.year}";
    String stopLabel(int s) =>
        s == 0 ? "Direct" : s == 1 ? "1 escale" : "2+ escales";

    final filtered = base
        .where((r) => matchesStops(r["stops"] as int))
        .take(5)
        .toList();

    return filtered
        .map((r) {
          final departStr =
              "${formatDate(widget.departDate) ?? "Date a definir"} - ${r["departTime"]}";
          final returnDepartStr = widget.tripType == 0
              ? "${formatDate(widget.retourDate) ?? "Date retour ?"} - ${r["returnDepartTime"]}"
              : null;

          return {
            ...r,
            "depart": departStr,
            "arrive": r["arrivalTime"],
            "returnDepart": returnDepartStr,
            "returnArrive": widget.tripType == 0 ? r["returnArriveTime"] : null,
            "from": widget.from,
            "to": widget.to,
            "fromCode": "YYZ",
            "toCode": "JFK",
            "stopsLabel": stopLabel(r["stops"] as int),
          };
        })
        .toList();
  }

  void _applySorting() {
    if (selectedTab == 1) {
      flights.sort((a, b) => a["price"].compareTo(b["price"]));
    } else if (selectedTab == 2) {
      flights.sort((a, b) => a["duration"].compareTo(b["duration"]));
    }
  }

  String _formatHeaderDate(DateTime? date, {String placeholder = "Date a definir"}) {
    return date == null
        ? placeholder
        : "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final departTxt = _formatHeaderDate(widget.departDate);
    final retourTxt = widget.tripType == 0
        ? _formatHeaderDate(widget.retourDate, placeholder: "Date retour ?")
        : "Aller simple";

    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F7),
      appBar: AppBar(
        title: const Text(
          "Resultats de recherche",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          // ----------------------- TABS ------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _tab("Meilleurs resultats", 0),
              _tab("Le moins cher", 1),
              _tab("Le plus rapide", 2),
            ],
          ),

          const SizedBox(height: 20),

          // -------------------- ROUTE INFO ---------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.from}  ->  ${widget.to}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.tripType == 0
                        ? "$departTxt - $retourTxt  |  ${widget.adults} Adultes"
                        : "$departTxt  |  ${widget.adults} Adultes",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // --------------------- FLIGHT LIST ------------------------
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: flights.length,
              itemBuilder: (context, index) {
                final vol = flights[index];
                return _flightCard(context, vol);
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
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

  // ----------------------- TAB BUTTON ------------------------
  Widget _tab(String text, int index) {
    final bool selected = (selectedTab == index);

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedTab = index;
            _applySorting();
          });
        },
        child: Container(
          height: 45,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF265F6A) : const Color(0xFFE3E3E3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ----------------------- FLIGHT CARD ------------------------
  Widget _flightCard(BuildContext context, Map<String, dynamic> vol) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CheapestFlightDetails(vol: vol)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vol["airline"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    vol["flightNumber"],
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${vol["depart"]}  ->  ${vol["arrive"]}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  if (widget.tripType == 0 && vol["returnDepart"] != null)
                    Text(
                      "${vol["returnDepart"]}  ->  ${vol["returnArrive"]}",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  Text(
                    vol["stopsLabel"],
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ),

            Text(
              "\$${vol["price"]}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
