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

### Tugas 8 
Pada Tugas 8, aplikasi dikembangkan dengan menambahkan halaman Education Form untuk memasukkan informasi pendidikan pengguna. Form ini dibuat menggunakan StatefulWidget dan Form dengan GlobalKey<FormState> untuk mengelola serta memvalidasi input.

Input yang tersedia:
   1. Institution: Nama institusi pendidikan.
   2. Degree / Program: Program atau jenjang pendidikan.
   3. Start Year: Tahun mulai pendidikan.
   4. Education Status: Status pendidikan, Currently Studying atau Graduated.
   5. Expected Graduation / Graduation Year: Tahun perkiraan kelulusan atau tahun kelulusan.

Fitur interaktif pada Education Form:
   1. Dropdown untuk memilih status pendidikan.
   2. Label tahun kelulusan berubah secara dinamis sesuai status yang dipilih.
   3. Validasi untuk memastikan input wajib diisi
   4. Validasi format tahun menggunakan empat digit
   5. Validasi rentang tahun dari 1900 sampai 2100.
   6. Validasi agar tahun kelulusan tidak lebih awal daripada tahun mulai pendidikan.

Serta AlertDialog menampilkan seluruh data ketika form berhasil divalidasi.

**Navigation Implementation**
Aplikasi menggunakan Navigator untuk berpindah halaman. Ketika pengguna memilih Home dari Drawer pada halaman form, aplikasi menggunakan Navigator.pushReplacement() untuk kembali ke halaman Home.

1. Navigator.push(): Membuka halaman baru di atas halaman sebelumnya.
2. Navigator.pushReplacement(): Mengganti halaman saat ini dengan halaman baru.
3. Navigator.pop(): Menutup halaman saat ini dan kembali ke halaman sebelumnya.
4. Pada aplikasi ini, Navigator.push() digunakan ketika pengguna membuka Education Form dari action card maupun Navigation Drawer.
5. Navigation Drawer juga tersedia pada Home Page dan halaman form, dengan pilihan Home, Add Project, dan Add Education.

**Responsive Layout and Form Design**
Education Form menggunakan SingleChildScrollView agar seluruh input dan tombol Save tetap dapat diakses ketika layar berukuran kecil atau keyboard sedang terbuka. Nah lalu Widget Column digunakan untuk menyusun seluruh input secara vertikal, sedangkan Padding digunakan untuk memberikan jarak antar-elemen. Selanjutnya untuk desain aplikasi mempertahankan identitas visual berupa warna biru dongker dan gradasi biru agar konsisten dengan halaman Home dan action cards.

**Reflection Questions**

1. **Apa perbedaan Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop()? Kapan masing-masing digunakan dalam aplikasi?**

   1. Navigator.push() menambahkan halaman baru ke navigation stack tanpa menghapus halaman sebelumnya. Pada aplikasi ini, metode tersebut digunakan untuk membuka Education Form dari Home Page atau Drawer.

   2. Navigator.pushReplacement() mengganti halaman yang sedang aktif dengan halaman baru sehingga halaman sebelumnya tidak lagi menjadi halaman aktif dalam stack. Pada aplikasi ini, metode tersebut digunakan ketika pengguna memilih Home dari Navigation Drawer.

   3. Navigator.pop() menutup halaman paling atas pada navigation stack dan kembali ke halaman sebelumnya. Pada aplikasi ini, metode tersebut digunakan untuk menutup AlertDialog setelah pengguna menekan tombol OK.

2. **Bagaimana struktur Scaffold, AppBar, dan Drawer diterapkan agar konsisten pada setiap halaman? Bagaimana warna tema membantu menjaga konsistensi desain?**

Scaffold digunakan sebagai struktur dasar setiap halaman. Di dalamnya terdapat AppBar untuk menampilkan judul halaman dan Drawer untuk menyediakan navigasi antarhalaman. Navigation Drawer dibuat dalam file terpisah, yaitu left_drawer.dart, sehingga dapat digunakan kembali pada Home Page, Project Form, dan Education Form. Penggunaan warna biru navy dan gradasi biru dongker membantu menjaga konsistensi tampilan aplikasi, terutama pada AppBar, Drawer, dan action cards.

3. **Bagaimana kamu memilih layout form dan mengatur spacing agar tetap nyaman digunakan pada layar kecil?**

Form menggunakan SingleChildScrollView yang membungkus Column. Dengan demikian, seluruh input dapat disusun secara vertikal dan halaman dapat digulir ketika konten melebihi tinggi layar. Setiap input diberikan Padding agar memiliki jarak yang cukup dan tidak terlihat terlalu rapat. Tombol Save juga ditempatkan setelah seluruh input sehingga pengguna dapat mengaksesnya dengan menggulir halaman.

4. **Apa fungsi GlobalKey<FormState>, validator, dan validate()? Berikan contoh input yang ditolak dan jelaskan alasannya.**

GlobalKey<FormState> digunakan untuk mengidentifikasi dan mengakses state dari widget Form. Melalui key tersebut, aplikasi dapat menjalankan validasi seluruh input. Nah validator merupakan fungsi yang memerisa nilai input dan mengembalikan pesan error apabila data tidak memenuhi ketentuan. Jika input valid, validator mengembalikan null. Untuk metode validate() digunakan untuk menjalankan seluruh validator dalam form. Jika terdapat input yang tidak valid, fungsi tersebut mengembalikan false dan pesan error ditampilkan pada field terkait.

Contoh input yang ditolak:

   1. Institution kosong atau hanya berisi spasi karena merupakan field wajib.
   2. Start Year berisi 24 karena format tahun harus terdiri dari empat digit.
   3. Graduation Year lebih awal daripada Start Year karena urutan tahun pendidikan tidak valid.
   4. Keyboard numerik saja tidak cukup untuk menjamin validitas data. Pengguna masih dapat memasukkan angka yang format atau rentangnya tidak sesuai. Oleh karena itu, validasi tetap diperlukan.

**AI Disclosure**

Dalam pengerjaan Tugas 8, saya menggunakan ChatGPT sebagai alat bantu pembelajaran dan pengembangan aplikasi Flutter. Saya menggunakan pendekatan bertahap dengan memberikan instruksi tugas, struktur kode yang sedang dikerjakan, serta hasil error atau output terminal. Selanjutnya, saya menerapkan perubahan secara bertahap dan memeriksa hasilnya sebelum melanjutkan ke tahap berikutnya.Untuk Verifikasi dan evaluasi saya lakukan secara mandiri Seluruh implementasi tetap diperiksa dan diuji secara langsung. Saya menjalankan aplikasi, mencoba navigasi dari action card dan Drawer, menguji validasi form dengan input yang valid maupun tidak valid, serta mencoba pilihan status pendidikan yang berbeda. AI saya gunakan sebagai alat bantu, bukan pengganti proses implementasi, pengujian, dan pemahaman terhadap kode saya. 

### Tugas 9

1. **Mengapa menggunakan `@JsonSerializable(fieldRename: FieldRename.snake)` dan `@JsonKey(includeToJson: false)`?**

   `@JsonSerializable` mempermudah konversi model Dart ke JSON dengan nama field yang sesuai dengan Django, seperti `is_current`. `includeToJson: false` pada `id` mencegah ID buatan server ikut dikirim saat POST. Pendekatan ini mengurangi risiko kesalahan penamaan field dan serialisasi.

2. **Mengapa Future diinisialisasi di `initState()` dan ApiClient melempar `ApiException`?**

   Future di `initState()` mencegah request dibuat ulang setiap kali `build()` dipanggil. `ApiException` membuat error HTTP dapat ditangani secara jelas, misalnya status 401 dapat digunakan untuk menghapus sesi dan meminta login kembali.

3. **Apa perbedaan SessionAuthentication dan TokenAuthentication? Mengapa mobile menggunakan TokenAuthentication?**

   `SessionAuthentication` menggunakan session dan cookie, cocok untuk website Django. `TokenAuthentication` menggunakan token pada header `Authorization`, sehingga sesuai untuk aplikasi Flutter mobile. SessionAuthentication tetap aktif agar website tetap dapat menggunakan autentikasi session.

4. **Apa peran job `build` dan `build_apk`? Mengapa `*.g.dart` di-ignore?**

   Job `build` menjalankan pemeriksaan formatting, analisis, lint, dan test. Job `build_apk` membangun APK release dan mengunggahnya sebagai artifact. File `*.g.dart` di-ignore karena merupakan hasil code generation; CI membuatnya kembali menggunakan `build_runner` sebelum analisis dan build.

### Setup

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8000
```

Backend Django: **[URL repository backend]**

### AI Disclosure

Saya menggunakan ChatGPT untuk memahami instruksi, menganalisis error, dan menyusun dokumentasi. Antigravity membantu implementasi model dan integrasi API Education serta Experience. Saya memeriksa dan menguji hasilnya melalui `flutter analyze`, `flutter test`, build APK, dan GitHub Actions. Beberapa saran AI perlu diperiksa manual, terutama konfigurasi Gradle dan perubahan file, karena AI tidak selalu mengetahui kondisi repository terbaru.