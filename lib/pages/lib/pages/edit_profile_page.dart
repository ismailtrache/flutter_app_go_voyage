import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
    required this.initialName,
    required this.initialEmail,
    required this.initialPhone,
    required this.initialCountry,
    this.initialImagePath,
  });

  final String initialName;
  final String initialEmail;
  final String initialPhone;
  final String initialCountry;
  final String? initialImagePath;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final Color primary = const Color(0xFF265F6A);

  final TextEditingController _nameController =
      TextEditingController();
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _phoneController =
      TextEditingController();
  final TextEditingController _countryController =
      TextEditingController();

  bool _notificationsEnabled = true;

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName;
    _emailController.text = widget.initialEmail;
    _phoneController.text = widget.initialPhone;
    _countryController.text = widget.initialCountry;
    if (widget.initialImagePath != null &&
        widget.initialImagePath!.isNotEmpty) {
      _imageFile = File(widget.initialImagePath!);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _changePhoto() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choisir depuis la galerie"),
                onTap: () async {
                  final XFile? picked =
                      await _picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
                  if (picked != null) {
                    setState(() {
                      _imageFile = File(picked.path);
                    });
                  }
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Prendre une photo"),
                onTap: () async {
                  final XFile? picked =
                      await _picker.pickImage(source: ImageSource.camera, imageQuality: 75);
                  if (picked != null) {
                    setState(() {
                      _imageFile = File(picked.path);
                    });
                  }
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text("Supprimer la photo"),
                onTap: () {
                  setState(() {
                    _imageFile = null;
                  });
                  Navigator.pop(ctx);
                },
              ),
              const SizedBox(height: 6),
            ],
          ),
        );
      },
    );
  }

  void _saveProfile() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final country = _countryController.text.trim();

    debugPrint("=== PROFIL SAUVEGARDE (SIMULATION) ===");
    debugPrint('Nom : $name');
    debugPrint('Email : $email');
    debugPrint('Telephone : $phone');
    debugPrint('Pays : $country');
    debugPrint('Notifications : $_notificationsEnabled');
    debugPrint('Photo choisie : ${_imageFile?.path}');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profil mis a jour (simulation locale)"),
      ),
    );

    Navigator.pop(context, {
      'name': name,
      'email': email,
      'phone': phone,
      'country': country,
      'notifications': _notificationsEnabled,
      'imagePath': _imageFile?.path,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Modifier le profil",
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
            // ===================== AVATAR MODIFIABLE =====================
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _changePhoto,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: const Color(0xFFE0E0E0),
                      backgroundImage:
                          _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? const Icon(
                              Icons.camera_alt,
                              size: 32,
                              color: Color(0xFF9E9E9E),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: _changePhoto,
                    child: const Text(
                      "Changer la photo",
                      style: TextStyle(
                        color: Color(0xFF265F6A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===================== CHAMPS DU PROFIL =====================
            _buildSectionTitle("Informations personnelles"),
            const SizedBox(height: 10),

            _buildTextField(
              label: "Nom complet",
              controller: _nameController,
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 14),

            _buildTextField(
              label: "Adresse e-mail",
              controller: _emailController,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 14),

            _buildTextField(
              label: "Téléphone",
              controller: _phoneController,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 14),

            _buildTextField(
              label: "Pays / Région",
              controller: _countryController,
              icon: Icons.public,
            ),

            const SizedBox(height: 24),

            // ===================== PRÉFÉRENCES =====================
            _buildSectionTitle("Préférences"),
            const SizedBox(height: 6),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                "Recevoir les notifications",
                style: TextStyle(fontSize: 16),
              ),
              subtitle: const Text(
                "Promotions, rappels de vols, mises à jour importantes",
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              activeColor: primary,
              value: _notificationsEnabled,
              onChanged: (v) {
                setState(() {
                  _notificationsEnabled = v;
                });
              },
            ),

            const SizedBox(height: 30),

            // ===================== BOUTON ENREGISTRER =====================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _saveProfile,
                child: const Text(
                  "Enregistrer",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===================== WIDGETS UTILITAIRES =====================

  Widget _buildSectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF265F6A)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFF265F6A),
            width: 1.4,
          ),
        ),
      ),
    );
  }
}
