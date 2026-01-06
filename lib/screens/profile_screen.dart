// screens/profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Curved gradient header
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9C88FF), Color(0xFF7B5CFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                ),

                // Content below header
                Column(
                  children: [
                    const SizedBox(height: 140),
                    // White content area starts here
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60), // space for avatar overlap
                          // Name & Email
                          const Text(
                            'Nama Pasien',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'pasien@meditech.com',
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 16),

                          // Health stats row
                          _buildHealthStats(),

                          const SizedBox(height: 20),

                          // Menu Groups
                          _buildMenuGroup(
                            title: 'Informasi Personal',
                            children: [
                              _buildMenuItem(
                                icon: Icons.person_outline,
                                title: 'Data Pribadi',
                                subtitle: 'Kelola informasi personal Anda',
                                onTap: () {},
                              ),
                              _buildMenuItem(
                                icon: Icons.medical_information_outlined,
                                title: 'Riwayat Kesehatan',
                                subtitle: 'Lihat riwayat medis lengkap',
                                onTap: () {
                                  Navigator.pushNamed(context, '/medical-history');
                                },
                              ),
                              _buildMenuItem(
                                icon: Icons.family_restroom,
                                title: 'Keluarga',
                                subtitle: 'Kelola profil keluarga',
                                onTap: () {},
                              ),
                            ],
                          ),

                          _buildMenuGroup(
                            title: 'Kesehatan',
                            children: [
                              _buildMenuItem(
                                icon: Icons.favorite_outline,
                                title: 'Kesehatan Saya',
                                subtitle: 'Monitor kondisi kesehatan',
                                onTap: () {},
                              ),
                              _buildMenuItem(
                                icon: Icons.calendar_today_outlined,
                                title: 'Jadwal Konsultasi',
                                subtitle: 'Kelola jadwal konsultasi',
                                onTap: () {},
                              ),
                              _buildMenuItem(
                                icon: Icons.medication_outlined,
                                title: 'Obat & Suplemen',
                                subtitle: 'Kelola obat dan suplemen',
                                onTap: () {},
                              ),
                            ],
                          ),

                          _buildMenuGroup(
                            title: 'Pengaturan',
                            children: [
                              _buildMenuItem(
                                icon: Icons.notifications_outlined,
                                title: 'Notifikasi',
                                subtitle: 'Pengaturan notifikasi',
                                onTap: () {},
                              ),
                              _buildMenuItem(
                                icon: Icons.security_outlined,
                                title: 'Keamanan',
                                subtitle: 'Password dan keamanan akun',
                                onTap: () {},
                              ),
                              _buildMenuItem(
                                icon: Icons.language_outlined,
                                title: 'Bahasa',
                                subtitle: 'Pilih bahasa aplikasi',
                                onTap: () {},
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Support & Logout grouped
                          _buildMenuGroup(
                            title: 'Bantuan & Dukungan',
                            children: [
                              _buildMenuItem(
                                icon: Icons.help_outline,
                                title: 'Pusat Bantuan',
                                subtitle: 'FAQ dan panduan penggunaan',
                                onTap: () {},
                              ),
                              _buildMenuItem(
                                icon: Icons.contact_support_outlined,
                                title: 'Hubungi Kami',
                                subtitle: 'Kontak customer service',
                                onTap: () {},
                              ),
                              _buildMenuItem(
                                icon: Icons.star_outline,
                                title: 'Beri Rating',
                                subtitle: 'Berikan rating untuk aplikasi',
                                onTap: () {},
                              ),
                              _buildMenuItem(
                                icon: Icons.logout,
                                title: 'Keluar',
                                subtitle: 'Logout dari akun',
                                textColor: Colors.red,
                                onTap: () {
                                  _showLogoutDialog(context);
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // App Version
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text('Meditech App', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700])),
                                  const SizedBox(height: 8),
                                  Text('Version 1.0.0', style: TextStyle(color: Colors.grey[600])),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),

                // Floating Avatar
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 56,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 56, color: Color(0xFF9C88FF)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 2,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/medical-history');
            break;
          case 2:
            // already on profile
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
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF9C88FF),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: (textColor == Colors.red ? Colors.red[50] : const Color(0xFFFAF7FF)),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: textColor ?? const Color(0xFF9C88FF),
          size: 22,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor ?? Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey[600],
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  Widget _buildMenuGroup({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(title, style: const TextStyle(color: Color(0xFF9C88FF), fontWeight: FontWeight.bold)),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildHealthStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _statCard('Umur', '24 Th'),
        const SizedBox(width: 10),
        _statCard('Berat', '65 Kg'),
        const SizedBox(width: 10),
        _statCard('Tinggi', '175 cm'),
      ],
    );
  }

  Widget _statCard(String label, String value) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          child: Column(
            children: [
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
              const SizedBox(height: 6),
              Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to login screen and clear all previous routes
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}