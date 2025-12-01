import 'package:flutter/material.dart';
import 'hotel_payment_method_page.dart';

class HotelResultsPage extends StatelessWidget {
  final String destination;
  final DateTime checkIn;
  final DateTime checkOut;
  final int adults;
  final int children;
  final int rooms;

  const HotelResultsPage({
    super.key,
    required this.destination,
    required this.checkIn,
    required this.checkOut,
    required this.adults,
    required this.children,
    required this.rooms,
  });

  String _formatDate(DateTime date) =>
      "${date.day}/${date.month}/${date.year}";

  List<Map<String, dynamic>> _mockHotels() {
    final stayNights = checkOut.difference(checkIn).inDays;
    return [
      {
        "name": "Hotel Central",
        "location": destination,
        "price": 145,
        "rating": 4.5,
        "distance": "0.8 km du centre",
        "amenities": ["WiFi", "Petit dejeuner", "Piscine"],
      },
      {
        "name": "Skyline Suites",
        "location": destination,
        "price": 190,
        "rating": 4.8,
        "distance": "1.2 km du centre",
        "amenities": ["WiFi", "Spa", "Salle de sport"],
      },
      {
        "name": "Eco Lodge",
        "location": destination,
        "price": 110,
        "rating": 4.2,
        "distance": "2.0 km du centre",
        "amenities": ["WiFi", "Parking", "Restaurant"],
      },
      {
        "name": "City Comfort",
        "location": destination,
        "price": 130,
        "rating": 4.0,
        "distance": "1.5 km du centre",
        "amenities": ["WiFi", "Navette aeroport", "Climatisation"],
      },
      {
        "name": "Boutique 27",
        "location": destination,
        "price": 210,
        "rating": 4.7,
        "distance": "0.5 km du centre",
        "amenities": ["WiFi", "Bar rooftop", "Room service"],
      },
    ]
        .map((h) => {
              ...h,
              "checkIn": checkIn,
              "checkOut": checkOut,
              "adults": adults,
              "children": children,
              "rooms": rooms,
              "nights": stayNights <= 0 ? 1 : stayNights,
              "destination": destination,
            })
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final hotels = _mockHotels();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text(
          "Offres hotels",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${_formatDate(checkIn)} - ${_formatDate(checkOut)}",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$adults adulte${adults > 1 ? 's' : ''}"
                    "${children > 0 ? " · $children enfant${children > 1 ? 's' : ''}" : ""}"
                    " · $rooms chambre${rooms > 1 ? 's' : ''}",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: hotels.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final hotel = hotels[index];
                return _hotelCard(context, hotel);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _hotelCard(BuildContext context, Map<String, dynamic> hotel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  hotel["name"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    "${hotel["rating"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            hotel["location"],
            style: TextStyle(color: Colors.grey[700]),
          ),
          Text(
            hotel["distance"],
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              for (final amenity in hotel["amenities"])
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9F2F4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    amenity,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${hotel["price"]} / nuit",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF265F6A),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HotelPaymentMethodPage(hotel: hotel),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  foregroundColor: const Color(0xFF265F6A),
                  side: const BorderSide(color: Color(0xFF265F6A)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Reserver"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
