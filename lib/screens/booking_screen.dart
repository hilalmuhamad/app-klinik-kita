import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/booking.dart';
import 'riwayat_booking_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController _namaPasienController = TextEditingController();
  String? _selectedDokter;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final List<String> _dokterList = [
    'Dokter Umum - dr. Indah',
    'Spesialis Kulit - dr. Rina',
    'Spesialis Gigi - drg. Budi',
  ];

  final List<Booking> _bookingHistory = [];

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _konfirmasiBooking() async {
    if (_namaPasienController.text.isEmpty ||
        _selectedDokter == null ||
        _selectedDate == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon lengkapi semua data.')),
      );
      return;
    }

    final String formattedDate =
        '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}';
    final String formattedTime = _selectedTime!.format(context);

    final Map<String, dynamic> dataBooking = {
      'nama': _namaPasienController.text,
      'dokter': _selectedDokter,
      'tanggal': formattedDate,
      'jam': formattedTime,
    };

    try {
      final response = await http.post(
        Uri.parse('http://172.16.0.2:3000/booking'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dataBooking),
      );

      if (response.statusCode == 200) {
        final newBooking = Booking(
          nama: _namaPasienController.text,
          dokter: _selectedDokter!,
          tanggal: formattedDate,
          jam: formattedTime,
        );

        setState(() {
          _bookingHistory.add(newBooking);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Booking berhasil: ${newBooking.nama} - ${newBooking.dokter} pada ${newBooking.tanggal} jam ${newBooking.jam}',
            ),
          ),
        );

        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      RiwayatBookingScreen(bookingList: _bookingHistory),
            ),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal mengirim booking ke server.')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Terjadi kesalahan saat mengirim booking.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: const Text(
          'Booking Konsultasi',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            const Text('Nama Pasien'),
            const SizedBox(height: 8),
            TextField(
              controller: _namaPasienController,
              decoration: _inputDecoration('Masukkan nama', Icons.person_outline),
            ),
            const SizedBox(height: 16),
            const Text('Pilih Dokter'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedDokter,
              items: _dokterList
                  .map(
                    (dokter) => DropdownMenuItem(
                      value: dokter,
                      child: Text(dokter),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _selectedDokter = value),
              decoration: _inputDecoration('Pilih dokter', Icons.medical_services_outlined),
            ),
            const SizedBox(height: 16),
            const Text('Pilih Tanggal'),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _selectDate,
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, color: Colors.grey[600]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Pilih Tanggal'
                            : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                        style: TextStyle(
                          color: _selectedDate == null ? Colors.grey[600] : Colors.black87,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Pilih Jam'),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _selectTime,
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time_outlined, color: Colors.grey[600]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _selectedTime == null ? 'Pilih Jam' : _selectedTime!.format(context),
                        style: TextStyle(
                          color: _selectedTime == null ? Colors.grey[600] : Colors.black87,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _konfirmasiBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9C88FF),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Konfirmasi',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.grey[600]),
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF9C88FF)),
      ),
    );
  }
}
