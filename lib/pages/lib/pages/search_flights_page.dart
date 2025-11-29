import 'package:flutter/material.dart';
import 'package:flutter_app_go_voyage/pages/lib/pages/historique.dart';
import 'package:flutter_app_go_voyage/pages/lib/pages/hotel_results_page.dart';
import 'package:flutter_app_go_voyage/pages/lib/pages/search_results_page.dart';

import 'home_page.dart';
import 'historique.dart';
import 'profile_page.dart';

class SearchFlightsPage extends StatefulWidget {
  final bool startWithHotel;

  const SearchFlightsPage({super.key, this.startWithHotel = false});

  @override
  State<SearchFlightsPage> createState() => _SearchFlightsPageState();
}

class _SearchFlightsPageState extends State<SearchFlightsPage> {
  late bool isFlightSelected;

  final fromController = TextEditingController(text: "Toronto");
  final toController = TextEditingController(text: "New York");

  DateTime? departDate;
  DateTime? retourDate;

  int adults = 2;

  int hotelAdults = 2;
  int hotelChildren = 0;
  int hotelRooms = 1;
  String hotelDestination = "Destination";
  DateTime? hotelCheckIn;
  DateTime? hotelCheckOut;

  int tripType = 0;
  int stopCount = 0;

  @override
  void initState() {
    super.initState();
    isFlightSelected = !widget.startWithHotel;
  }

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
            Center(
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png', height: 110),
                  const SizedBox(height: 10),
                  const Text(
                    "GO TRAVEL",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF265F6A),
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
            Container(
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _TabButton(
                      isSelected: isFlightSelected,
                      label: "Vols",
                      icon: Icons.flight,
                      onTap: () => setState(() => isFlightSelected = true),
                    ),
                  ),
                  Expanded(
                    child: _TabButton(
                      isSelected: !isFlightSelected,
                      label: "Hotels",
                      icon: Icons.bed,
                      onTap: () => setState(() => isFlightSelected = false),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            if (isFlightSelected) ...[
              _buildInputField(
                icon: Icons.search,
                text: fromController.text,
                trailingIcon: Icons.edit,
                onTap: () async {
                  final value = await _openTextEditor(
                    "Ville de depart",
                    fromController.text,
                  );
                  if (value != null && value.trim().isNotEmpty) {
                    setState(() => fromController.text = value.trim());
                  }
                },
              ),
              const SizedBox(height: 15),
              _buildInputField(
                icon: Icons.search,
                text: toController.text,
                trailingIcon: Icons.edit,
                onTap: () async {
                  final value = await _openTextEditor(
                    "Ville d'arrivee",
                    toController.text,
                  );
                  if (value != null && value.trim().isNotEmpty) {
                    setState(() => toController.text = value.trim());
                  }
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      text: departDate == null
                          ? "Depart"
                          : "${departDate!.day}/${departDate!.month}/${departDate!.year}",
                      trailingIcon: Icons.calendar_today,
                      onTap: () async {
                        final selected = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (selected != null) {
                          setState(() => departDate = selected);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField(
                      text: retourDate == null
                          ? "Retour"
                          : "${retourDate!.day}/${retourDate!.month}/${retourDate!.year}",
                      trailingIcon: Icons.calendar_today,
                      onTap: () async {
                        final selected = await showDatePicker(
                          context: context,
                          initialDate: departDate ?? DateTime.now(),
                          firstDate: departDate ?? DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (selected != null) {
                          setState(() => retourDate = selected);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              _buildInputField(
                icon: Icons.person_outline,
                text: "$adults Adultes",
                trailingIcon: Icons.keyboard_arrow_down,
                onTap: () async {
                  final value = await showDialog<int>(
                    context: context,
                    builder: (context) => SimpleDialog(
                      title: const Text("Nombre d'adultes"),
                      children: [
                        for (int i = 1; i <= 10; i++)
                          SimpleDialogOption(
                            onPressed: () => Navigator.pop(context, i),
                            child: Text("$i adulte${i > 1 ? 's' : ''}"),
                          ),
                      ],
                    ),
                  );
                  if (value != null) {
                    setState(() => adults = value);
                  }
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _dropdownField(
                      label: tripType == 0 ? "Aller-Retour" : "Aller Simple",
                      onTap: () async {
                        final value = await showDialog<int>(
                          context: context,
                          builder: (context) => SimpleDialog(
                            title: const Text("Type de voyage"),
                            children: [
                              SimpleDialogOption(
                                onPressed: () => Navigator.pop(context, 0),
                                child: const Text("Aller-Retour"),
                              ),
                              SimpleDialogOption(
                                onPressed: () => Navigator.pop(context, 1),
                                child: const Text("Aller Simple"),
                              ),
                            ],
                          ),
                        );
                        if (value != null) {
                          setState(() {
                            tripType = value;
                            if (tripType == 1) {
                              retourDate = null;
                            }
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _dropdownField(
                      label: stopCount == 0
                          ? "Direct"
                          : stopCount == 1
                              ? "1 Escale"
                              : "2+ Escales",
                      onTap: () async {
                        final value = await showDialog<int>(
                          context: context,
                          builder: (context) => SimpleDialog(
                            title: const Text("Nombre d'escales"),
                            children: [
                              SimpleDialogOption(
                                onPressed: () => Navigator.pop(context, 0),
                                child: const Text("Direct"),
                              ),
                              SimpleDialogOption(
                                onPressed: () => Navigator.pop(context, 1),
                                child: const Text("1 Escale"),
                              ),
                              SimpleDialogOption(
                                onPressed: () => Navigator.pop(context, 2),
                                child: const Text("2+ Escales"),
                              ),
                            ],
                          ),
                        );
                        if (value != null) {
                          setState(() => stopCount = value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ] else ...[
              _buildInputField(
                icon: Icons.location_on_outlined,
                text: hotelDestination,
                trailingIcon: Icons.edit,
                onTap: () async {
                  final value =
                      await _openTextEditor("Destination", hotelDestination);
                  if (value != null && value.trim().isNotEmpty) {
                    setState(() => hotelDestination = value.trim());
                  }
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      text: hotelCheckIn == null
                          ? "Arrivee"
                          : "${hotelCheckIn!.day}/${hotelCheckIn!.month}/${hotelCheckIn!.year}",
                      trailingIcon: Icons.calendar_today,
                      onTap: () async {
                        final selected = await showDatePicker(
                          context: context,
                          initialDate: hotelCheckIn ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (selected != null) {
                          setState(() {
                            hotelCheckIn = selected;
                            if (hotelCheckOut != null &&
                                hotelCheckOut!.isBefore(selected)) {
                              hotelCheckOut = null;
                            }
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField(
                      text: hotelCheckOut == null
                          ? "Depart"
                          : "${hotelCheckOut!.day}/${hotelCheckOut!.month}/${hotelCheckOut!.year}",
                      trailingIcon: Icons.calendar_today,
                      onTap: () async {
                        final selected = await showDatePicker(
                          context: context,
                          initialDate: hotelCheckIn ?? DateTime.now(),
                          firstDate: hotelCheckIn ?? DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (selected != null) {
                          setState(() => hotelCheckOut = selected);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              _buildInputField(
                icon: Icons.person_outline,
                text:
                    "${hotelAdults + hotelChildren} Personnes, $hotelRooms Chambre${hotelRooms > 1 ? 's' : ''}",
                trailingIcon: Icons.keyboard_arrow_down,
                onTap: () async {
                  final result = await _openHotelGuestsSelector();
                  if (result != null) {
                    setState(() {
                      hotelAdults = result["adults"]!;
                      hotelChildren = result["children"]!;
                      hotelRooms = result["rooms"]!;
                    });
                  }
                },
              ),
            ],
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    if (isFlightSelected) {
                      if (departDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Choisissez une date de depart")),
                        );
                        return;
                      }
                      if (tripType == 0 && retourDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Choisissez une date de retour")),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SearchResultsPage(
                            from: fromController.text,
                            to: toController.text,
                            departDate: departDate,
                            retourDate: tripType == 0 ? retourDate : null,
                            adults: adults,
                            tripType: tripType,
                            stopCount: stopCount,
                          ),
                        ),
                      );
                    } else {
                      if (hotelDestination.trim().isEmpty ||
                          hotelDestination == "Destination") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Choisissez une destination")),
                        );
                        return;
                      }
                      if (hotelCheckIn == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Choisissez une date d'arrivee")),
                        );
                        return;
                      }
                      if (hotelCheckOut == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Choisissez une date de depart")),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HotelResultsPage(
                            destination: hotelDestination,
                            checkIn: hotelCheckIn!,
                            checkOut: hotelCheckOut!,
                            adults: hotelAdults,
                            children: hotelChildren,
                            rooms: hotelRooms,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 241, 243, 244),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isFlightSelected ? "Rechercher" : "Voir les offres",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
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
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
              break;
            case 1:
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HistoriquePage()),
              );
              break;
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

  Widget _buildInputField({
    IconData? icon,
    required String text,
    IconData? trailingIcon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
            if (trailingIcon != null)
              Icon(trailingIcon, color: Colors.grey[800]),
          ],
        ),
      ),
    );
  }

  Widget _dropdownField({required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.black87),
          ],
        ),
      ),
    );
  }

  Future<String?> _openTextEditor(String label, String initial) {
    final controller = TextEditingController(text: initial);

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(label),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, int>?> _openHotelGuestsSelector() {
    int adults = hotelAdults;
    int children = hotelChildren;
    int rooms = hotelRooms;

    return showDialog<Map<String, int>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Invites & chambres"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _numberSelector(
                label: "Adultes",
                value: adults,
                min: 1,
                onChanged: (v) => adults = v,
              ),
              _numberSelector(
                label: "Enfants",
                value: children,
                min: 0,
                onChanged: (v) => children = v,
              ),
              _numberSelector(
                label: "Chambres",
                value: rooms,
                min: 1,
                onChanged: (v) => rooms = v,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, {
                "adults": adults,
                "children": children,
                "rooms": rooms,
              }),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget _numberSelector({
    required String label,
    required int value,
    required int min,
    required ValueChanged<int> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: value > min ? () => onChanged(value - 1) : null,
            ),
            Text("$value", style: const TextStyle(fontSize: 16)),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => onChanged(value + 1),
            ),
          ],
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  final bool isSelected;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _TabButton({
    required this.isSelected,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF265F6A) : const Color(0xFFD6D6D6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black87,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
