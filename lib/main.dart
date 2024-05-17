import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    final response = await http.post(
      Uri.parse('http://192.168.135.251/app_kb/login.php'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(responseData),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text(responseData['message']),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to connect to the server.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

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
      ),
      body: _options.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'KB Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Reminders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Scheduling',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.red, // Ubah warna ikon saat tidak terpilih
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  ProfilePage(this.userData);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Populate text controllers with initial user data
    nameController.text = widget.userData['name'];
    birthDateController.text = widget.userData['birth_date'];
    addressController.text = widget.userData['address'];
    phoneNumberController.text = widget.userData['phone_number'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            TextField(
              controller: birthDateController,
              decoration: InputDecoration(labelText: 'Birth Date'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ElevatedButton(
              onPressed: () {
                // Implement update functionality here
                // You can use http.post to send updated data to your API
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}

class KBInformationPage extends StatelessWidget {
  final Map<String, dynamic> userData;

  KBInformationPage(this.userData);

  @override
  Widget build(BuildContext context) {
    final String userID = userData['user_id'];

    return Scaffold(
      body: ListView(
        children: [
          CustomCard(
            title: "Pil KB",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => KBInformationDetailPage(
                    title: "Pil KB",
                    information:
                        "Pil KB adalah pil hormonal yang mengandung estrogen dan progestin. Mereka bekerja dengan mencegah ovulasi dan membuat lendir serviks tebal sehingga sulit bagi sperma untuk mencapai sel telur.\n\nKelebihan:\n- Kemudahan penggunaan, cukup diminum setiap hari.\n- Menstruasi bisa menjadi lebih teratur dan ringan.\n- Beberapa jenis pil dapat mengurangi risiko kanker ovarium dan kanker endometrium.\n\nKekurangan:\n- Memerlukan kepatuhan yang tinggi dalam penggunaannya, harus diminum setiap hari pada waktu yang sama.\n- Efek samping seperti mual, perubahan mood, dan peningkatan risiko pembekuan darah.\n- Tidak melindungi dari penyakit menular seksual (PMS).",
                    userID: userID,
                  ),
                ),
              );
            },
          ),
          CustomCard(
            title: "KB Implan",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => KBInformationDetailPage(
                    title: "KB Implan",
                    information:
                        "KB implan adalah stik kecil yang dimasukkan di bawah kulit lengan yang melepaskan hormon kontrasepsi.\n\nKelebihan:\n- Efektif selama beberapa tahun (biasanya 3-5 tahun) tanpa perlu perhatian sehari-hari.\n- Menstruasi bisa menjadi lebih ringan atau bahkan berhenti sama sekali.\n- Tidak perlu mengingat atau mengambil sesuatu setiap hari.\n\nKekurangan:\n- Dapat menyebabkan efek samping seperti perubahan mood, sakit kepala, dan perdarahan tidak teratur.\n- Memerlukan prosedur medis untuk pemasangan dan pengangkatannya.\n- Tidak melindungi dari PMS.",
                    userID: userID,
                  ),
                ),
              );
            },
          ),
          CustomCard(
            title: "Suntik KB",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => KBInformationDetailPage(
                    title: "Suntik KB",
                    information:
                        "Suntik KB adalah suntikan hormonal yang diberikan setiap 1-3 bulan, tergantung pada jenisnya.\n\nKelebihan:\n- Efektif dan nyaman karena hanya perlu diingat setiap beberapa bulan.\n- Dapat mengurangi nyeri menstruasi dan volume haid.\n- Tidak perlu diingat setiap hari.\n\nKekurangan:\n- Dapat menyebabkan perdarahan tidak teratur atau absen, serta perubahan berat badan.\n- Tidak melindungi dari PMS.\n- Memerlukan kunjungan rutin ke penyedia layanan kesehatan untuk injeksi.",
                    userID: userID,
                  ),
                ),
              );
            },
          ),
          CustomCard(
            title: "IUD",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => KBInformationDetailPage(
                    title: "IUD",
                    information:
                        "IUD adalah alat kecil yang dimasukkan ke dalam rahim oleh tenaga medis. Tersedia dalam versi hormonal (yang melepaskan hormon) dan non-hormonal (berbasis tembaga).\n\nKelebihan:\n1. Efektif dan tahan lama. IUD hormonal dapat bertahan antara 3-5 tahun, sedangkan IUD non-hormonal dapat bertahan antara 10-12 tahun.\n2. Tidak perlu diingat setiap hari atau setiap beberapa bulan.\n3. Tidak ada pengaruh hormon terhadap berat badan atau mood pada IUD non-hormonal.\n\nKekurangan:\n1. Dapat menyebabkan efek samping seperti kram perut dan perdarahan tidak teratur pada awal penggunaan.\n2. Memerlukan pemasangan oleh profesional medis.\n3. Ada risiko komplikasi seperti perforasi rahim saat pemasangan.",
                    userID: userID,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  CustomCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}

class KBInformationDetailPage extends StatelessWidget {
  final String title;
  final String information;
  final String userID;

  KBInformationDetailPage({
    required this.title,
    required this.information,
    required this.userID,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        // Ikon kembali di AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'User ID: $userID',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10), // Jarak antara User ID dan informasi
              Text(
                information,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RemindersPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  RemindersPage(this.userData);

  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  String selectedContraceptiveMethod = '';
  String breastfeedingStatus = '';
  String contraceptiveDuration = '';

  @override
  Widget build(BuildContext context) {
    final String userID = widget.userData['user_id'];

    // List of contraceptive methods
    List<String> contraceptiveMethods = [
      'Pil KB',
      'Suntik',
      'IUD',
      'Implan',
    ];

    // List of breastfeeding statuses
    List<String> breastfeedingStatuses = [
      'Sedang Menyusui',
      'Tidak Menyusui',
    ];

    // List of contraceptive durations
    List<String> contraceptiveDurations = [
      '1 Tahun',
      '3 Tahun',
    ];

    return Center(
      child: Column(
        children: [
          Text('User ID: $userID'),
          SizedBox(height: 5),
          // Dropdown to select contraceptive method
          DropdownButtonFormField(
            value: selectedContraceptiveMethod.isNotEmpty
                ? selectedContraceptiveMethod
                : null,
            items: contraceptiveMethods.map((method) {
              return DropdownMenuItem(
                value: method,
                child: Text(method),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedContraceptiveMethod = value.toString();
                // Reset selected values when contraceptive method changes
                breastfeedingStatus = '';
                contraceptiveDuration = '';
              });
            },
            decoration: InputDecoration(
              labelText: 'Pilih Metode Kontrasepsi',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          // Dropdown to select breastfeeding status
          if (selectedContraceptiveMethod == 'Pil KB')
            DropdownButtonFormField(
              value:
                  breastfeedingStatus.isNotEmpty ? breastfeedingStatus : null,
              items: breastfeedingStatuses.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  breastfeedingStatus = value.toString();
                });
              },
              decoration: InputDecoration(
                labelText: 'Status Menyusui',
                border: OutlineInputBorder(),
              ),
            ),
          SizedBox(height: 20),
          // Dropdown to select contraceptive duration
          if (selectedContraceptiveMethod == 'IUD')
            DropdownButtonFormField(
              value: contraceptiveDuration.isNotEmpty
                  ? contraceptiveDuration
                  : null,
              items: contraceptiveDurations.map((duration) {
                return DropdownMenuItem(
                  value: duration,
                  child: Text(duration),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  contraceptiveDuration = value.toString();
                });
              },
              decoration: InputDecoration(
                labelText: 'Durasi Kontrasepsi',
                border: OutlineInputBorder(),
              ),
            ),
        ],
      ),
    );
  }
}

class SchedulingPage extends StatelessWidget {
  final Map<String, dynamic> userData;

  SchedulingPage(this.userData);

  Future<List<dynamic>> fetchSchedules(int userId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.135.251/app_kb/schedule.php?user_id=$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load schedules');
    }
  }

  void _showEditDialog(BuildContext context, dynamic schedule) {
    TextEditingController noteController =
        TextEditingController(text: schedule['note']);
    TextEditingController dateController =
        TextEditingController(text: schedule['schedule_date']);
    TextEditingController methodController =
        TextEditingController(text: schedule['method_id']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Schedule'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: noteController,
                  decoration: InputDecoration(labelText: 'Note'),
                ),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(labelText: 'Date'),
                ),
                TextField(
                  controller: methodController,
                  decoration: InputDecoration(labelText: 'Method'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Tambahkan logika untuk menyimpan perubahan jadwal
                // Misalnya, Anda bisa menggunakan http.put untuk mengirim permintaan PUT ke server
                // Setelah itu, dapat menampilkan pesan sukses atau gagal, dan jika sukses, refresh halaman
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSchedule(BuildContext context, dynamic schedule) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Schedule'),
          content: Text('Are you sure you want to delete this schedule?'),
          actions: [
            TextButton(
              onPressed: () {
                // Tambahkan logika untuk menghapus jadwal
                // Misalnya, Anda bisa menggunakan http.delete untuk mengirim permintaan DELETE ke server
                // Setelah itu, dapat menampilkan pesan sukses atau gagal, dan jika sukses, refresh halaman
                Navigator.of(context).pop(); // Tutup dialog konfirmasi
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog konfirmasi
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String userID = userData['user_id'];

    return FutureBuilder<List<dynamic>>(
      future: fetchSchedules(int.parse(userID)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Scaffold(
            body: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final schedule = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(schedule['note']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: ${schedule['schedule_date']}'),
                        Text('Method: ${schedule['method_id']}'),
                        // Tambahkan informasi tambahan lainnya di sini sesuai kebutuhan
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditDialog(context, schedule);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteSchedule(context, schedule);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
