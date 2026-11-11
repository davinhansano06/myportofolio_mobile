# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



### Tugas 7

1. **Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!**

   Widget tree adalah struktur hierarki yang menggambarkan susunan widget dalam aplikasi Flutter. Setiap widget dapat memiliki widget lain sebagai anak (child). Widget parent bertanggung jawab mengatur tata letak atau perilaku widget child. Contohnya, `MaterialApp` menjadi root widget, kemudian memiliki `Scaffold` sebagai halaman utama, yang di dalamnya terdapat `AppBar`, `Column`, `Row`, dan widget lainnya.

2. **Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!**

   - `MaterialApp`: Menjadi root aplikasi dan mengatur tema serta halaman utama.
   - `Scaffold`: Menyediakan struktur dasar halaman aplikasi.
   - `AppBar`: Menampilkan bagian header aplikasi.
   - `Text`: Menampilkan teks.
   - `Padding`: Memberikan jarak di sekitar widget.
   - `Column`: Menyusun widget secara vertikal.
   - `Row`: Menyusun widget secara horizontal.
   - `Center`: Menempatkan widget di tengah.
   - `Card`: Menampilkan informasi dalam bentuk kartu.
   - `Container`: Mengatur ukuran, padding, dan dekorasi widget.
   - `InfoCard`: Menampilkan informasi NPM, nama, dan kelas.
   - `GridView.count`: Menyusun tombol menu dalam bentuk grid.
   - `Material`: Memberikan dasar visual Material Design pada kartu.
   - `Ink`: Menyediakan dekorasi gradasi pada kartu.
   - `InkWell`: Memberikan interaksi sentuhan dan efek ripple.
   - `ItemCard`: Menampilkan tombol aksi dengan ikon, teks, dan warna gradasi.
   - `Icon`: Menampilkan ikon pada tombol.
   - `SnackBar`: Menampilkan notifikasi ketika tombol ditekan.
   - `SizedBox`: Memberikan jarak antar-widget.
   - `Padding`: Memberikan ruang di sekitar konten.

3. **Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!**

   `MaterialApp` merupakan widget utama yang menyediakan konfigurasi Material Design untuk aplikasi Flutter. Widget ini mengatur tema, navigasi, dan halaman awal aplikasi. MaterialApp digunakan sebagai root widget karena menjadi dasar bagi widget lain untuk memperoleh konfigurasi dan tampilan yang konsisten.

4. **Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?**

   `StatelessWidget` adalah widget yang tidak memiliki state internal yang berubah selama siklus hidupnya. Widget ini cocok digunakan untuk tampilan statis seperti kartu informasi dan tombol menu pada proyek ini.

   Sementara itu, `StatefulWidget` adalah widget yang memiliki state yang dapat berubah selama aplikasi berjalan. Widget ini cocok digunakan ketika tampilan perlu diperbarui berdasarkan interaksi pengguna atau perubahan data, misalnya counter dan form interaktif.

5. **Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?**

   `BuildContext` adalah referensi terhadap posisi sebuah widget dalam widget tree. BuildContext memungkinkan widget mengakses informasi dari widget parent atau ancestor, seperti tema aplikasi menggunakan `Theme.of(context)` dan ukuran layar menggunakan `MediaQuery.of(context)`. BuildContext digunakan dalam metode `build()` untuk memperoleh informasi tersebut saat membangun tampilan widget.

6. **Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?**

   Hot reload adalah fitur Flutter yang menerapkan perubahan kode ke aplikasi yang sedang berjalan tanpa mengulang seluruh aplikasi dan umumnya mempertahankan state yang ada.

   Hot restart memulai ulang aplikasi dari awal sehingga state aplikasi di-reset. Hot reload cocok untuk perubahan tampilan atau kode widget, sedangkan hot restart diperlukan ketika perubahan membutuhkan inisialisasi ulang state atau struktur awal aplikasi. Full restart dapat diperlukan ketika perubahan konfigurasi atau native code tidak dapat diterapkan melalui hot reload.

### AI Disclosure

Dalam pengerjaan Tugas 7, saya menggunakan ChatGPT sebagai alat bantu untuk memahami materi Flutter, memperoleh arahan implementasi widget, membantu mengidentifikasi dan memperbaiki error, serta menyusun draf jawaban pertanyaan reflektif. Saya tetap melakukan implementasi, menjalankan aplikasi, menguji tampilan dan interaksi, serta memeriksa kode menggunakan `flutter analyze`. Saya juga menyesuaikan tampilan kartu menggunakan gradasi warna biru dongker sesuai preferensi desain saya.
