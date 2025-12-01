import 'package:flutter/material.dart';
import '../../../theme_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  bool _biometric = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paramètres',
          style: TextStyle(color: colorScheme.primary),
        ),
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeController.instance.themeMode,
              builder: (_, mode, __) {
                final isDark = mode == ThemeMode.dark;
                return SwitchListTile(
                  title: const Text('Mode sombre'),
                  subtitle: const Text('Activer le thème foncé pour toute l’appli'),
                  activeColor: colorScheme.primary,
                  value: isDark,
                  onChanged: (v) => ThemeController.instance.setDark(v),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SwitchListTile(
              title: const Text('Notifications'),
              subtitle:
                  const Text('Recevoir des rappels et infos importantes'),
              activeColor: colorScheme.primary,
              value: _notifications,
              onChanged: (v) => setState(() => _notifications = v),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SwitchListTile(
              title: const Text('Connexion biométrique'),
              subtitle: const Text('Utiliser empreinte/face pour sécuriser'),
              activeColor: colorScheme.primary,
              value: _biometric,
              onChanged: (v) => setState(() => _biometric = v),
            ),
          ),
        ],
      ),
      backgroundColor: scaffoldBg,
    );
  }
}
