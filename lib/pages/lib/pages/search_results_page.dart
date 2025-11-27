import 'package:flutter/material.dart';
import 'cheapest_flight_page.dart';

class SearchResultsPage extends StatefulWidget {
  final String from;
  final String to;
  final DateTime? departDate;
  final DateTime? retourDate;
  final int adults;

  const SearchResultsPage({
    super.key,
    required this.from,
    required this.to,
    required this.departDate,
    required this.retourDate,
    required this.adults,
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

    flights = [
      {
        "airline": "Air Canada",
        "flightNumber": "AC-421",
        "cabin": "Economy",
        "price": 310,
        "duration": 4.30,
        "depart": "15 Oct · 4:30 pm",
        "arrive": "7:50 am",
        "returnDepart": "20 Oct · 4:30 pm",
        "returnArrive": "7:50 am",
        "image": "assets/images/eco_seat.jpg",
        "services": ["Repas", "WiFi", "Divertissement"],
        "from": widget.from,
        "to": widget.to,
        "fromCode": "YYZ",
        "toCode": "JFK",
      },
      {
        "airline": "American Airlines",
        "flightNumber": "AA-102",
        "cabin": "Business",
        "price": 350,
        "duration": 3.50,
        "depart": "15 Oct · 5:30 pm",
        "arrive": "8:50 am",
        "returnDepart": "20 Oct · 5:30 pm",
        "returnArrive": "8:50 am",
        "image": "assets/images/business_seat.jpg",
        "services": ["Repas Premium", "WiFi+", "Salon VIP"],
        "from": widget.from,
        "to": widget.to,
        "fromCode": "YYZ",
        "toCode": "JFK",
      },
      {
        "airline": "United Airlines",
        "flightNumber": "UA-887",
        "cabin": "First Class",
        "price": 300,
        "duration": 2.45,
        "depart": "15 Oct · 4:30 pm",
        "arrive": "7:50 am",
        "returnDepart": "20 Oct · 4:30 pm",
        "returnArrive": "7:50 am",
        "image": "assets/images/first_seat.jpg",
        "services": ["Champagne", "Suite Privée", "VIP Service"],
        "from": widget.from,
        "to": widget.to,
        "fromCode": "YYZ",
        "toCode": "JFK",
      },
    ];
  }

  
  void applySorting() {
    setState(() {
      if (selectedTab == 1) {
        // ⬅ Le moins cher
        flights.sort((a, b) => a["price"].compareTo(b["price"]));
      } else if (selectedTab == 2) {
      
        flights.sort((a, b) => a["duration"].compareTo(b["duration"]));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              _tab("Meilleurs résultats", 0),
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
                  Text("${widget.from}  →  ${widget.to}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(
                    "${widget.departDate!.day}/${widget.departDate!.month}/${widget.departDate!.year} - "
                    "${widget.retourDate!.day}/${widget.retourDate!.month}/${widget.retourDate!.year}  |  ${widget.adults} Adultes",
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
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: ""),
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
          selectedTab = index;
          applySorting();
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
                  Text(vol["airline"],
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(vol["flightNumber"],
                      style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  const SizedBox(height: 10),
                  Text("${vol["depart"]}  →  ${vol["arrive"]}",
                      style: const TextStyle(fontSize: 14)),
                  Text("${vol["returnDepart"]}  →  ${vol["returnArrive"]}",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
            ),

            Text(
              "\$${vol["price"]}",
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
