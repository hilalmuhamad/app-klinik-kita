import 'package:flutter/material.dart';

class RekamMedisScreen extends StatelessWidget {
  const RekamMedisScreen({super.key});

  final List<Map<String, String>> rekamMedisData = const [
    {
      'dokter': 'dr. Indah Pratiwi',
      'spesialis': 'Dokter Umum',
      'tanggal': '3 Juli 2025',
      'diagnosa': 'Demam dan flu ringan',
    },
    {
      'dokter': 'dr. Agus Permana',
      'spesialis': 'Dokter Gigi',
      'tanggal': '4 Juli 2025',
      'diagnosa': 'Sakit gigi - diberikan antibiotik',
    },
    {
      'dokter': 'dr. Rina S.',
      'spesialis': 'Spesialis Kulit',
      'tanggal': '10 Juni 2025',
      'diagnosa': 'Dermatitis ringan',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header
          Container(
            height: 160,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF9C88FF), Color(0xFF7B5CFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 36, color: Color(0xFF9C88FF)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Hilal Muhamad', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text('RM-2024-089', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: rekamMedisData.length,
              itemBuilder: (context, index) {
                final item = rekamMedisData[index];
                return _buildRecordCard(context, item);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              break;
            case 1:
              // already on Rekam Medis
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF9C88FF),
        unselectedItemColor: Colors.grey[400],
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Rekam Medis'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildRecordCard(BuildContext context, Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: dokter, spesialis and date
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['dokter'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(item['spesialis'] ?? '', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                Text(item['tanggal'] ?? '', style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            const SizedBox(height: 12),

            // Dashed separator
            const MySeparator(),
            const SizedBox(height: 12),

            // Bottom: diagnosa and booking
            Row(
              children: [
                Icon(Icons.note_alt_outlined, color: Colors.grey[700]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item['diagnosa'] ?? '',
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking ulang ke ${item['dokter']}')));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9C88FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    elevation: 0,
                  ),
                  child: const Text('Booking Ulang', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

// Custom dashed separator using LayoutBuilder and Flex
class MySeparator extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashSpace;

  const MySeparator({Key? key, this.height = 1, this.color = const Color(0xFFE0E0E0), this.dashWidth = 6, this.dashSpace = 4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final boxWidth = constraints.constrainWidth();
      final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(dashCount, (_) {
          return Padding(
            padding: EdgeInsets.only(right: dashSpace),
            child: Container(
              width: dashWidth,
              height: height,
              color: color,
            ),
          );
        }),
      );
    });
  }
}
