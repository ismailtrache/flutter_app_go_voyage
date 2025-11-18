import 'package:flutter/material.dart';

class SearchFlightsPage extends StatefulWidget {
  /// false = commencer sur Vols
  /// true  = commencer sur Hotels
  final bool startWithHotel;

  const SearchFlightsPage({super.key, this.startWithHotel = false});

  @override
  State<SearchFlightsPage> createState() => _SearchFlightsPageState();
}

class _SearchFlightsPageState extends State<SearchFlightsPage> {
  late bool isFlightSelected;

  // Champs de texte
  final fromController = TextEditingController(text: "Toronto");
  final toController = TextEditingController(text: "New York");

  // Dates
  DateTime? departDate;
  DateTime? retourDate;

  // Adultes vol
  int adults = 2;

  // Hôtel
  int hotelAdults = 2;
  int hotelChildren = 0;
  int hotelRooms = 1;

  // 🔥 Nouveau : Aller-retour + escales
  int tripType = 0; // 0 = Aller-Retour, 1 = Aller simple
  int stopCount = 0; // 0 = Direct, 1 = 1 escale, 2 = 2+ escales

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

            // LOGO
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

            // Onglets Vols / Hotels
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

            // ---------------- FORMULAIRE VOLS ----------------
            if (isFlightSelected) ...[
              _buildInputField(
                icon: Icons.search,
                text: fromController.text,
                trailingIcon: Icons.edit,
                onTap: () async {
                  final value = await _openTextEditor("Ville de départ", fromController.text);
                  if (value != null) setState(() => fromController.text = value);
                },
              ),
              const SizedBox(height: 15),

              _buildInputField(
                icon: Icons.search,
                text: toController.text,
                trailingIcon: Icons.edit,
                onTap: () async {
                  final value = await _openTextEditor("Ville d'arrivée", toController.text);
                  if (value != null) setState(() => toController.text = value);
                },
              ),

              const SizedBox(height: 15),

              // Dates aller + retour
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      text: departDate == null
                          ? "Départ"
                          : "${departDate!.day}/${departDate!.month}/${departDate!.year}",
                      trailingIcon: Icons.calendar_today,
                      onTap: () async {
                        final selected = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (selected != null) setState(() => departDate = selected);
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
                        if (selected != null) setState(() => retourDate = selected);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Adultes
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
                  if (value != null) setState(() => adults = value);
                },
              ),

              const SizedBox(height: 15),

              // 🔥 Aller-Retour + Escales
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
                        if (value != null) setState(() => tripType = value);
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
                        if (value != null) setState(() => stopCount = value);
                      },
                    ),
                  ),
                ],
              ),

            ]

            // ---------------- FORMULAIRE HOTELS ----------------
            else ...[
              _buildInputField(
                icon: Icons.location_on_outlined,
                text: "Destination",
                trailingIcon: Icons.edit,
                onTap: () async => _openTextEditor("Destination", ""),
              ),
              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      text: "Arrivée",
                      trailingIcon: Icons.calendar_today,
                      onTap: () async => showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField(
                      text: "Départ",
                      trailingIcon: Icons.calendar_today,
                      onTap: () async => showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      ),
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

            // BOUTON
            Center(
              child: Container(
                width: 180,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF265F6A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    isFlightSelected ? "Rechercher" : "Voir les offres",
                    style: const TextStyle(
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
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }

  // -----------------------------------------------------
  // WIDGETS REUTILISABLES
  // -----------------------------------------------------

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

  Widget _dropdownField({
    required String label,
    required VoidCallback onTap,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 16, color: Colors.black87)),
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
          title: const Text("Invités & chambres"),
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

// Onglet haut
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
