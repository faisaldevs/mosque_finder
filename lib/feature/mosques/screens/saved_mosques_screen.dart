import 'package:flutter/material.dart';

import '../models/mosque.dart';
import 'detail_screen.dart';

class SavedMosquesScreen extends StatefulWidget {
  final double userLat;
  final double userLng;
  const SavedMosquesScreen({
    super.key,
    required this.userLat,
    required this.userLng,
  });

  @override
  State<SavedMosquesScreen> createState() => _SavedMosquesScreenState();
}

class _SavedMosquesScreenState extends State<SavedMosquesScreen> {
  List<Mosque> _saved = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    // final list = await SavedMosqueService.getSaved();
    // setState(() => _saved = list);
  }

  Future<void> _remove(String id) async {
    // await SavedMosqueService.remove(id);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Mosques'),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _saved.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 56,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No saved mosques yet',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tap the bookmark icon on any mosque to save it',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _saved.length,
              itemBuilder: (_, i) {
                final m = _saved[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    leading: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text('🕌', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    title: Text(
                      m.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: m.address != null
                        ? Text(m.address!, style: const TextStyle(fontSize: 12))
                        : null,
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.bookmark,
                        color: Color(0xFF1B5E20),
                      ),
                      onPressed: () => _remove(m.id),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(
                          mosque: m,
                          userLat: widget.userLat,
                          userLng: widget.userLng,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
