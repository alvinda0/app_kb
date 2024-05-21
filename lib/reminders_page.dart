import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RemindersPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  RemindersPage(this.userData);

  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  String selectedContraceptiveMethod = '';
  String contraceptiveDuration = '';
  TextEditingController dateTimeController = TextEditingController();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  void _showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), // Durasi tampilan snackbar
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> addSchedule() async {
    final String userID = widget.userData['user_id'];
    final String apiUrl = 'http://192.168.248.163/app_kb/tambah_schedule.php';

    // Data yang akan dikirim ke server
    Map<String, String> data = {
      'user_id': userID,
      'schedule_date': dateTimeController.text,
      'note': selectedContraceptiveMethod, // Pilih Metode Kontrasepsi
      'note_detail': contraceptiveDuration, // Durasi Kontrasepsi
    };

    try {
      // Kirim permintaan POST ke server
      final response = await http.post(Uri.parse(apiUrl), body: data);

      // Periksa status kode respons
      if (response.statusCode == 200) {
        // Tampilkan pesan sukses jika berhasil
        print('Data berhasil ditambahkan.');
        // Tampilkan snackbar
        _showSnackbar('Jadwal berhasil disimpan');
      } else {
        // Tampilkan pesan gagal jika respons tidak berhasil
        print('Gagal menambahkan data: ${response.reasonPhrase}');
        // Tampilkan snackbar dengan pesan gagal
        _showSnackbar('Gagal menyimpan jadwal');
      }
    } catch (error) {
      // Tangani kesalahan koneksi atau lainnya
      print('Error: $error');
      // Tampilkan snackbar dengan pesan error
      _showSnackbar('Terjadi kesalahan: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String userID = widget.userData['user_id'];

    // Daftar metode kontrasepsi
    List<String> contraceptiveMethods = [
      'Pil KB',
      'Suntik',
      'IUD',
      'Implan',
    ];

    // Daftar status menyusui
    List<String> breastfeedingStatuses = [
      'Pil kombinasi',
      'Pil progestin (pil mini)',
    ];

    // Daftar durasi kontrasepsi
    List<String> contraceptiveDurations = [
      'IUD hormonal',
      'IUD non hormonal',
    ];

    // Peta yang berisi semua nilai dropdown untuk setiap metode kontrasepsi
    Map<String, List<String>> dropdownValues = {
      'Pil KB': breastfeedingStatuses,
      'Suntik': ['Suntik kombinasi', 'Suntik DMPA'],
      'IUD': contraceptiveDurations,
      'Implan': [
        'Norplant',
        'Sino-Implant 2',
        'Jadelle',
        'Implanon',
        'Nexplanon'
      ],
    };

    return Center(
      child: Column(
        children: [
          Text('User ID: $userID'),
          SizedBox(height: 5),
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
                // Reset nilai terpilih saat metode kontrasepsi berubah
                contraceptiveDuration = '';
              });
            },
            decoration: InputDecoration(
              labelText: 'Pilih Metode Kontrasepsi',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          DropdownButtonFormField(
            value:
                contraceptiveDuration.isNotEmpty ? contraceptiveDuration : null,
            items: dropdownValues[selectedContraceptiveMethod]?.map((duration) {
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
          SizedBox(height: 20),
          TextFormField(
            controller: dateTimeController,
            decoration: InputDecoration(
              labelText: 'Tanggal dan Waktu (YYYY-MM-DD HH:MM)',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final DateTime? pickedDateTime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 5),
                      );
                      if (pickedDateTime != null) {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            final DateTime combinedDateTime = DateTime(
                              pickedDateTime.year,
                              pickedDateTime.month,
                              pickedDateTime.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                            var selectedDateTime = combinedDateTime;
                            dateTimeController.text =
                                dateFormat.format(selectedDateTime);
                          });
                        }
                      }
                    },
                    child: Text('Pilih Tanggal dan Waktu'),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    addSchedule();
                  },
                  child: Text('Simpan'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
