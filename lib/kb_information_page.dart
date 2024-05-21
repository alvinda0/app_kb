import 'package:flutter/material.dart';
import 'kb_information_detail_page.dart';
import 'custom_card.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KBInformationDetailPage(
                    title: "Kontrasepsi Pil",
                    information:
                        "Kontrasepsi pil adalah metode yang efektif untuk mencegah kehamilan, pada penggunaan yang sempurna efektivitasnya 99,5-99,9% dan salah satu metode yang paling disukai karena kesuburan cepat kembali setelah penggunaan pil dihentikan. Ada dua macam kontrasepsi pil, yaitu: pil kombinasi dan pil progestin\n\nPil kombinasi adalah jenis kontrasepsi yang paling umum digunakan, mengandung estrogen dan progesterone. Estrogen yang biasa digunakan adalah ethinyl estradiol dengan dosis 0,05 mcg per tablet; progestin yang digunakan bervariasi.\n\nPil progestin (pil mini) mengandung progestin dosis kecil, sekitar 0,5 mg atau kurang, tanpa estrogen. Tanpa kombinasi dengan estrogen, progestin lebih sering menimbulkan perdarahan tidak teratur.\n\nPEMAKAIAN :\nPil kombinasi : diminum setiap hari dalam 3 minggu dan diikuti periode 1 minggu tanpa pil.\nPil progestin (pil mini) : Pil mini harus diminum setiap hari juga saat menstruasi.\n\nKEUNTUNGAN :\nefektif mencegah kehamilan, dapat digunakan pada masa remaja hingga menopause, membuat siklus haid menjadi teratur.\n\nKEKURANGAN :\ntidak melindungi dari penyakit menular seksual, pendarahan tidak teratur dan spotting, tidak cocok untuk perempuan yang mengalami kondisi tertentu, seperti kanker payudara, kanker rahim, penyakit jantung, tekanan darah tinggi, dan gangguan hati",
                    userID: userID,
                  ),
                ),
              );
            },
          ),
          CustomCard(
            title: "KB Implan",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KBInformationDetailPage(
                    title: "Alat Kontrasepsi Dalam Rahim (IUD)",
                    information:
                        "Intra Uterine Devices (IUD) atau Alat Kontrasepsi Dalam Rahim (AKDR) merupakan salah satu kontrasepsi jangka panjang yang efektif, aman, dan reversibel, dimana terbuat dari plastik atau logam kecil yang dililit dengan tembaga dengan berbagai ukuran dan dimasukkan ke dalam uterus, Ada 2 jenis IUD, yaitu : IUD hormonal (berisi hormon progestin) dan IUD non hormonal (terbuat dari tembaga).\n\nPEMAKAIAN :\nIUD hormonal dapat bertahan 5 tahun. Sementara IUD tembaga dapat bertahan hingga 5 - 10 tahun.\n\nKEUNTUNGAN :\ndapat dipakai oleh semua perempuan dalam usia produktif, dapat di gunakan sampai menopause, efektifitas baik dalam mencegah kehamilan, bertahan jangka panjang lebih dari 5 tahun, tidak memerlukan perawatan yang rumit.\n\nKEKURANGAN :\ntidak dapat mencegah penyakit menular seksual, IUD bergeser dan keluar dari tempatnya, biaya lebih mahal, perubahan siklus menstruasi, spotting, amenorhea, dismenorhea, dan pendarahan post seksual",
                    userID: userID,
                  ),
                ),
              );
            },
          ),
          CustomCard(
            title: "Suntik KB",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KBInformationDetailPage(
                    title: "Kontrasepsi Suntik",
                    information:
                        "Kontrasepsi suntik adalah alat kontrasepsi berupa cairan yang berisi hormone progestron yang disuntikkan ke dalam tubuh secara periodik (1 bulan sekali atau 3 bulan sekali). Ada 2 jenis suntik KB, yakni KB suntik setiap 1 bulan (kombinasi) dan 3 bulan (DMPA). Metode ini praktis, efektif, dan aman dengan tingkat keberhasilan lebih dari 99%.\n\nSuntik kombinasi adalah mirip dengan pil kombinasi yang mengandung estrogen dan progestin lebih sedikit dibandingkan DMPA, sehingga dapat mengurangi efek samping perdarahan tidak teratur.\n\nSuntik DMP (Depo-Medroxyprogesterone Acetate) merupakan metode kontrasepsi hormonal yang hanya mengandung progesteron 150 mg.\n\nPEMAKAIAN :\nSuntik kombinasi : dilakukan satu kali setiap 28 hingga 30 hari.\nSuntik DMP : disuntikkan secara intramuskular setiap 3 bulan.\n\nKEUNTUNGAN :\nPraktis, efektif, dan aman dalam mencegah kehamilan, bertahan jangka panjang hingga 3 bulan, lebih praktis dari pada pil KB, tidak mengganggu seks.\n\nKEKURANGAN :\nTidak dapat mencegah penyakit menular seksual, periode menstruasi terganggu, berat badan yang bertambah, mual dan pusing, dan bisa menyebabkan warna biru dan rasa nyeri pada daerah suntikan",
                    userID: userID,
                  ),
                ),
              );
            },
          ),
          CustomCard(
            title: "IUD",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KBInformationDetailPage(
                    title: "Alat Kontrasepsi Dalam Rahim (IUD)",
                    information:
                        "Intra Uterine Devices (IUD) atau Alat Kontrasepsi Dalam Rahim (AKDR) merupakan salah satu kontrasepsi jangka panjang yang efektif, aman, dan reversibel, dimana terbuat dari plastik atau logam kecil yang dililit dengan tembaga dengan berbagai ukuran dan dimasukkan ke dalam uterus, Ada 2 jenis IUD, yaitu : IUD hormonal (berisi hormon progestin) dan IUD non hormonal (terbuat dari tembaga).\n\nPEMAKAIAN :\nIUD hormonal dapat bertahan 5 tahun. Sementara IUD tembaga dapat bertahan hingga 5 - 10 tahun.\n\nKEUNTUNGAN :\ndapat dipakai oleh semua perempuan dalam usia produktif, dapat di gunakan sampai menopause, efektifitas baik dalam mencegah kehamilan, bertahan jangka panjang lebih dari 5 tahun, tidak memerlukan perawatan yang rumit.\n\nKEKURANGAN :\ntidak dapat mencegah penyakit menular seksual, IUD bergeser dan keluar dari tempatnya, biaya lebih mahal, perubahan siklus menstruasi, spotting, amenorhea, dismenorhea, dan pendarahan post seksual",
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
