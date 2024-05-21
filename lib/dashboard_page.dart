import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'kb_information_page.dart';
import 'reminders_page.dart';
import 'scheduling_page.dart';

class DashboardPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  DashboardPage(this.userData);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions(Map<String, dynamic> userData) => [
        ProfilePage(userData),
        KBInformationPage(userData),
        RemindersPage(userData),
        SchedulingPage(userData),
      ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> _options = _widgetOptions(widget.userData);

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Keluarga Berencana'),
        automaticallyImplyLeading: false, // Menghapus tombol "back"
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Implementasi logika logout atau keluar aplikasi di sini
              // Misalnya, Anda dapat mengarahkan pengguna kembali ke halaman login
              // atau melakukan tindakan lain yang sesuai.
              // Di sini, saya akan menutup aplikasi.
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: _options.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Informasi KB',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'penjadwalan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'riwayat penjadwalan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.blue, // Ubah warna ikon saat tidak terpilih
        onTap: _onItemTapped,
      ),
    );
  }
}
