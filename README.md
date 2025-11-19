Tugas 7
1. Apa itu widget tree pada Flutter dan bagaimana hubungan parent-child bekerja antar widget?

Widget tree adalah struktur hierarki dari seluruh widget yang membentuk tampilan aplikasi Flutter. Setiap widget berada di dalam sebuah pohon (tree), di mana ada widget induk (parent) dan widget anak (child). Parent bertanggung jawab menentukan bagaimana child muncul dan berperilaku (misalnya layout, posisi, atau style). Child tidak bisa berdiri sendiri tanpa parent, sehingga hubungan parent-child memastikan UI tersusun secara terstruktur, modular, dan mudah diatur.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

(Silakan kamu sesuaikan sendiri sesuai project, berikut formatnya contoh)

MaterialApp → Mengatur tema, route, dan menjadi root dari aplikasi.
Scaffold → Menyediakan struktur dasar halaman seperti AppBar, body, dan drawer.
AppBar → Bagian header di atas halaman.
Drawer → Panel navigasi samping untuk berpindah halaman.
Padding → Memberi jarak di sekitar widget.
Column/Row → Menyusun widget secara vertikal/horizontal.
Container → Mengatur ukuran, padding, margin, dan dekorasi.
ElevatedButton → Tombol untuk aksi tertentu.
Text → Menampilkan tulisan.
ListView → Menampilkan daftar widget yang bisa discroll.
SingleChildScrollView → Membuat halaman dapat discroll meski hanya punya satu child.
TextField → Input form.
Image.asset → Menampilkan gambar dari assets.

3. Apa fungsi dari widget MaterialApp? Mengapa sering digunakan sebagai widget root?

MaterialApp berfungsi sebagai pembungkus utama aplikasi yang menggunakan desain Material Design. Di dalamnya kita bisa mengatur tema, routing, warna, dan konfigurasi global lainnya.
Widget ini sering digunakan sebagai root karena menyediakan fondasi standar yang memudahkan pembuatan UI modern, konsisten, dan responsif sesuai Material Design.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan memilih salah satunya?

StatelessWidget → Tidak memiliki state yang berubah. Cocok untuk UI statis, seperti teks, icon, atau layout yang tidak berubah.
StatefulWidget → Memiliki state yang bisa berubah saat aplikasi berjalan. Cocok untuk form, counter, input user, atau data yang dinamis.
Pemilihan tergantung kebutuhan: jika UI tidak berubah, pakai Stateless. Jika butuh perubahan tampilan berdasarkan interaksi atau data, pakai Stateful.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

BuildContext adalah objek yang menyimpan informasi posisi widget dalam widget tree. BuildContext penting karena digunakan untuk:
mengakses widget parent,
menjalankan navigator,
memakai theme, dan mencari widget di atasnya dalam tree.

Pada metode build(), BuildContext dipakai untuk membangun UI berdasarkan lokasi widget, misalnya Theme.of(context) atau Navigator.push(context, ...).

6. Jelaskan konsep hot reload dan bagaimana bedanya dengan hot restart.

Hot reload → Memuat ulang perubahan kode tanpa menghapus state aplikasi. Cocok untuk mengedit UI, layout, dan style.
Hot restart → Mengulang aplikasi dari awal sehingga state hilang. Cocok saat mengubah variabel global, mengubah main(), atau ada error yang menempel di state.

Tugas 8
1. Jelaskan perbedaan Navigator.push() dan Navigator.pushReplacement(). Dalam kasus apa dipakai di aplikasi Football Shop?

Navigator.push() → Menambah halaman baru di atas halaman sebelumnya. Halaman sebelumnya tetap ada di stack.
Navigator.pushReplacement() → Mengganti halaman saat ini dengan halaman baru, halaman sebelumnya dihapus dari stack.
Pada aplikasi Football Shop:
push() cocok untuk navigasi normal, misalnya dari Home ke Detail Produk.
pushReplacement() cocok untuk halaman yang tidak perlu kembali ke halaman sebelumnya, misalnya setelah login selesai masuk ke Home.

2. Bagaimana memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten?

Saya menggunakan kombinasi Scaffold, AppBar, dan Drawer untuk menciptakan struktur halaman yang seragam. Scaffold menjadi kerangka utama halaman, AppBar dipakai untuk menampilkan judul dan identitas halaman, sedangkan Drawer menyediakan navigasi global antarhalaman. Dengan membuat struktur ini konsisten, seluruh halaman dalam aplikasi terasa menyatu dan mudah digunakan.

3. Kelebihan menggunakan Padding, SingleChildScrollView, dan ListView untuk elemen form. Berikan contoh penggunaannya.

Padding → Memberikan ruang sehingga elemen form tidak saling menempel dan lebih nyaman dilihat.
SingleChildScrollView → Membuat form panjang tetap bisa discroll tanpa overflow di layar kecil.
ListView → Efektif untuk menampilkan daftar elemen form atau list produk karena bisa scroll otomatis dan hemat memori.
Contoh dari aplikasi Football Shop:
Form input alamat pengiriman dibungkus SingleChildScrollView agar tidak overflow.
Setiap TextField diberi Padding agar tampilan lebih rapi.
Daftar produk pada halaman Shop ditampilkan dalam ListView.

4. Bagaimana menyesuaikan warna tema agar aplikasi Football Shop punya identitas visual yang konsisten?

Saya menyesuaikan parameter theme pada MaterialApp, seperti primaryColor, colorScheme, dan scaffoldBackgroundColor. Warna yang dipilih mengikuti branding toko (misalnya biru dan putih). Dengan menentukan tema di level aplikasi, semua widget yang memakai theme otomatis mengikuti warna tersebut sehingga tampilannya konsisten di setiap halaman.

Tugas 9

1. Pentingnya Model Dart untuk JSON

Kita perlu membuat Model Dart (Class) untuk data JSON demi menjamin keamanan tipe (type safety), memanfaatkan Null Safety Dart, dan meningkatkan maintainability kode.

Konsekuensi Tanpa Model (Menggunakan Map<String, dynamic> Langsung)

Validasi tipe: Lemah. Harus melakukan casting manual. Kesalahan tipe hanya terdeteksi saat runtime dan bisa menyebabkan crash.
Null safety: Berisiko. Data null dapat diakses tanpa pengecekan ketat, berpotensi memicu runtime error.
Maintainability: Rendah. Kode berulang, bergantung pada string keys yang rentan typo, dan sulit direfaktor jika struktur API berubah.

2. Fungsi package:http dan CookieRequest

package:http → Klien HTTP dasar untuk GET/POST, tetapi tidak mengelola sesi/cookie secara otomatis.

CookieRequest → Klien HTTP custom yang aware terhadap cookie. Menyimpan Session ID dan CSRF Token secara otomatis.

Perbedaan peran: http adalah alat dasar komunikasi HTTP. CookieRequest menambahkan kecerdasan manajemen sesi di atas fungsi dasar http.

3. Alasan instance CookieRequest Perlu Dibagikan

Memelihara status sesi dari Django (Session ID) yang diterima saat login.
Semua request selanjutnya harus memakai Session ID yang sama.
Membagi satu instance CookieRequest (via Provider/Singleton) memastikan semua request otomatis terautentikasi.

4. Konfigurasi Konektivitas Flutter-Django

Tambahkan 10.0.2.2 → IP khusus emulator Android untuk mengakses localhost PC. Harus ada di ALLOWED_HOSTS.
Aktifkan CORS → Karena Flutter dan Django beda origin. Tanpa CORS: request diblokir.
Pengaturan SameSite/Cookie → Pengaturan cookie modern bisa memblokir pengiriman sesi. Atur SESSION_COOKIE_SAMESITE bila perlu.
Izin internet Android → Tambahkan <uses-permission android:name="android.permission.INTERNET"/>. Tanpa ini: Connection refused.

5. Mekanisme Pengiriman Data

Flutter menerima input user.
Data dimasukkan ke Model Dart.
Model Dart dikonversi ke JSON melalui toJson().
CookieRequest mengirim POST ke Django.
Django mendeserialisasi JSON dan memprosesnya.
Django merespons dengan JSON hasil.
Flutter menerima respons, mengubah JSON ke Model Dart (fromJson()).
UI menampilkan hasil.

6. Mekanisme Autentikasi (Login, Register, Logout)

Register: Flutter kirim POST → Django validasi → buat user → return 201.
Login: Django verifikasi → membuat sesi → mengirim Set-Cookie → CookieRequest menyimpan sesi.
Akses terautentikasi: Semua request CookieRequest otomatis menyertakan cookie sesi.
Logout: Django menghapus sesi → CookieRequest membersihkan cookie lokal.

7. Implementasi Step-by-Step
A. Persiapan Server Django

Jalankan Django (127.0.0.1:8000) dan konfigurasi CORS + ALLOWED_HOSTS.
Buat endpoint /register/, /login/, /logout/ menggunakan mekanisme session.
Definisikan model item + serializer + endpoint /api/items/ (GET, POST) dengan login_required.
Buat endpoint /api/my-items/ untuk filter item berdasarkan request.user.

B. Persiapan Klien Flutter

Tambah izin INTERNET di AndroidManifest dan package http/provider di pubspec.yaml.
Buat model Dart (ItemModel, UserModel) lengkap dengan fromJson/toJson.
Implementasikan class CookieRequest sebagai singleton untuk manajemen sesi.
Daftarkan instance CookieRequest ke Provider/DI utama di main.dart.
Buat AuthService untuk register, login, logout menggunakan CookieRequest.
Buat ItemService untuk fetchPublicItems dan fetchUserItems.
Implementasi UI:
Halaman login/register
Halaman daftar item (ListView)
Halaman item milik user (filtered)
Halaman detail item (terima objek ItemModel sebagai argumen)