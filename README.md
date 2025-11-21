# Jawaban

## Perbedaan Cubit dan Bloc
**Cubit:** lebih sederhana, langsung memanggil fungsi untuk mengubah state (tanpa event).

**Bloc:** lebih kompleks, menggunakan event → state, cocok untuk aplikasi besar.

## Alasan memisahkan model data, logika bisnis, dan UI
Agar kode rapi, mudah dirawat, mudah diuji, tidak saling bergantung, dan mudah dikembangkan.

## Tiga contoh state dalam Cubit/Bloc
**Initial State:** keadaan awal sebelum proses dimulai.


**Loading State:** saat proses sedang berjalan.


**Success State:** proses berhasil dan data siap ditampilkan.

