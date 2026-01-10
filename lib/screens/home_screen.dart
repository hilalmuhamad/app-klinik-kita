import 'package:flutter/material.dart';
import 'jadwal_konsultasi_screen.dart';
import 'booking_screen.dart';
import 'rekam_medis_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final String _userName = "Hilal Muhamad";
  int _coinBalance = 120;

  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'Jadwal Konsultasi',
      'image': 'assets/images/jadwalkonsultasi.png',
      'route': '/jadwal-konsultasi',
    },
    {
      'title': 'Booking',
      'image': 'assets/images/booking.png',
      'route': '/booking',
    },
    {
      'title': 'Rekam Medis',
      'image': 'assets/images/rekammedis.png',
      'route': '/medical-history',
    },
  ];

  final List<Map<String, String>> _healthProducts = [
    {'name': 'Vitamin C', 'price': 'Rp 25.000'},
    {'name': 'Paracetamol', 'price': 'Rp 15.000'},
    {'name': 'Antimo', 'price': 'Rp 8.000'},
    {'name': 'Betadine', 'price': 'Rp 12.000'},
    {'name': 'Bodrex', 'price': 'Rp 10.000'},
    {'name': 'OBH Combi', 'price': 'Rp 18.000'},
  ];

  // Dummy berita kesehatan (news) untuk ditampilkan di bagian bawah
  final List<Map<String, String>> _newsList = [
    {
      "title": "Infografis Jadwal Imsakiyah 1446 H Ramadhan 2025 u...",
      "date": "Tanggal tidak ditemukan",
      "image": "assets/images/news_placeholder.png",
    },
    {
      "title": "Infografis KPK Geledah Kediaman Ridwan Kamil Terka...",
      "date": "Tanggal tidak ditemukan",
      "image": "assets/images/news_placeholder.png",
    },
    {
      "title": "Pengumuman SNBP 2025 pada 18 Maret 2025, Begini Ca...",
      "date": "14 menit lalu",
      "image": "assets/images/news_placeholder.png",
    },
    {
      "title": "Rano Karno Buka Festival Beduk DKI Jakarta 2025...",
      "date": "15 menit lalu",
      "image": "assets/images/news_placeholder.png",
    },
    {
      "title": "Ular Laut Terbesar Sepanjang Masa Tumbuh Hingga 12...",
      "date": "15 menit lalu",
      "image": "assets/images/news_placeholder.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildHeader(context),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: -28,
                      child: _buildSearchBar(),
                    ),
              ],
                ),
                SizedBox(height: 40),
                _buildCoinWidget(),
                SizedBox(height: 12),
                _buildMenuSection(),
            _buildHealthSummary(),
            _buildProductsSection(),
            _buildTipsSection(),
            _buildNewsSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Custom gradient header to replace standard AppBar
  Widget _buildHeader(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top + 16;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, topPadding, 20, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF9C88FF), Color(0xFF7B5CFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _navigateToProfile,
            child: Hero(
              tag: 'profile_avatar',
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white.withOpacity(0.18),
                child: Icon(Icons.person, color: Colors.white, size: 28),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang,',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _userName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.white70),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Fitur notifikasi akan segera hadir')),
              );
            },
          ),
        ],
      ),
    );
  }

  // Method untuk navigasi ke profile dengan error handling
  void _navigateToProfile() {
    try {
      Navigator.pushNamed(context, '/profile').then((value) {
        // Reset bottom navigation index saat kembali dari profile
        setState(() {
          _currentIndex = 0;
        });
      });
    } catch (e) {
      // Error handling jika route tidak ditemukan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal membuka halaman profile'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Floating search bar placed between header and content
  Widget _buildSearchBar() {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey[500]),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari layanan, produk, atau artikel',
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Pencarian: $value')),
                  );
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.mic, color: Color(0xFF9C88FF)),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoinWidget() {
    return Container(
      margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Saldo koin: $_coinBalance')),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFC107),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.monetization_on, color: Colors.white),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Koin Anda', style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Text('$_coinBalance koin', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Fitur top-up belum tersedia')),
                    );
                  },
                  child: Text('Isi', style: TextStyle(color: Color(0xFF9C88FF))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Health Summary section with simple mock visualizations
  Widget _buildHealthSummary() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ringkasan Kesehatan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Langkah Harian', style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.72,
                          color: Color(0xFF9C88FF),
                          backgroundColor: Color(0xFF9C88FF).withOpacity(0.15),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text('72%', style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Kualitas Tidur', style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.58,
                          color: Color(0xFF9C88FF),
                          backgroundColor: Color(0xFF9C88FF).withOpacity(0.15),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text('58%', style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tips & Berita section (horizontal scroll)
  Widget _buildTipsSection() {
    final List<Map<String, String>> tips = List.generate(6, (index) => {
          'title': 'Tips Kesehatan #${index + 1}',
          'image': '',
        });

    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 32),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tips & Berita',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: tips.length,
              separatorBuilder: (_, __) => SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = tips[index];
                return SizedBox(
                  width: 220,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(
                          width: 90,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child: Icon(Icons.article, color: Colors.grey[500], size: 40),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(item['title']!,
                                    style: TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(height: 6),
                                Text('Ringkasan singkat artikel kesehatan.',
                                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // News section (horizontal ListView) displayed at the bottom
  Widget _buildNewsSection() {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 32),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Berita Kesehatan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _newsList.length,
              separatorBuilder: (_, __) => SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = _newsList[index];
                return SizedBox(
                  width: 260,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(
                          width: 110,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Icon(Icons.image_not_supported, color: Colors.grey[400]),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item['title']!,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  item['date']!,
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            _menuItems.map((item) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: _buildMenuCard(
                    title: item['title'],
                    image: item['image'],
                    onTap: () {
                      if (item['route'] == '/jadwal-konsultasi') {
                        Navigator.of(
                          context,
                        ).push(_fadeSlideRoute(const JadwalKonsultasiScreen()));
                      } else if (item['route'] == '/booking') {
                        Navigator.of(
                          context,
                        ).push(_fadeSlideRoute(const BookingScreen()));
                      } else if (item['route'] == '/medical-history') {
                        Navigator.of(
                          context,
                        ).push(_fadeSlideRoute(const RekamMedisScreen()));
                      }
                    },
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  PageRouteBuilder _fadeSlideRoute(Widget screen) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildMenuCard({
    required String title,
    required String image,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  image,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback jika gambar tidak ditemukan
                    return Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey[400],
                    );
                  },
                ),
              ),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductsSection() {
    return Container(
      margin: EdgeInsets.only(top: 24),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Produk Kesehatan Andalan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3,
            ),
            itemCount: _healthProducts.length,
            itemBuilder: (context, index) {
              final product = _healthProducts[index];
              return _buildProductCard(
                name: product['name']!,
                price: product['price']!,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard({required String name, required String price}) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Color(0xFF9C88FF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.medical_services,
              color: Color(0xFF9C88FF),
              size: 16,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  price,
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });

        switch (index) {
          case 0:
            // already on home
            break;
          case 1:
            // Replace with RekamMedis screen
            Navigator.pushReplacementNamed(context, '/medical-history');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/profile');
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF9C88FF),
      unselectedItemColor: Colors.grey[400],
      elevation: 8,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          label: 'Rekam Medis',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}