# K3 Advisor Management (Frontend)

**Risk Advisor Management** (`k3-frontend`) adalah aplikasi Flutter untuk manajemen risiko (K3) yang berisi dashboard risiko, prediksi AI, notifikasi lokal, dan rekomendasi solusi.

---

## 📦 Struktur Proyek

````
lib/
├── core/
│   ├── constants/   # warna, style, teks
│   ├── services/    # ApiService, notifikasi, helper
│   └── widgets/     # widget umum seperti AppCard
├── features/
│   ├── dashboard/   # halaman dashboard risiko
│   ├── prediction_ai/ # modul prediksi AI
│   ├── solutions/   # modul rekomendasi solusi
│   └── notifications/ # modul notifikasi
├── main.dart
└── app.dart

pubspec.yaml
README.md
"""

(Ini adalah struktur ringkas — sesuaikan bila ada folder/file tambahan.)

---

## ⚙️ Persiapan & Setup

Ikuti langkah ini untuk menyiapkan lingkungan dan menjalankan aplikasi secara lokal.

1. **Clone repository**

```bash
git clone https://github.com/yantoww/k3-frontend.git
cd k3-frontend
````

2. **Install dependencies**

```bash
flutter pub get
```

3. **Jalankan aplikasi**

* Hubungkan emulator atau perangkat fisik.
* Jalankan:

```bash
flutter run
```

4. **(Opsional) Tambahkan backend URL**

Sesuaikan `baseUrl` di `ApiService` agar mengarah ke backend kamu. Jika proyek menggunakan environment file (.env), lakukan konfigurasi sesuai kebutuhan.

---

## ✅ Modul Utama & Fungsionalitas

* **Dashboard** — Menampilkan meter risiko, ringkasan, dan tren harian.
* **AI Prediction** — Mengambil prediksi risiko dan faktor penyebab dari backend.
* **Solutions** — Form input risiko → kirim ke backend → tampilkan rekomendasi solusi.
* **Notifications** — Menampilkan notifikasi lokal (percobaan / demo).

---

## 🧪 Cara Kontribusi

Kontribusi sangat disambut! Panduan singkat:

1. Fork repositori ini.
2. Buat branch baru:

```bash
git checkout -b feat/nama-fitur-anda
```

3. Lakukan perubahan dan jalankan tes UI / fitur:

```bash
flutter pub get
# jalankan aplikasi dan tes manual
```

4. Commit perubahan dengan pesan yang jelas:

```bash
git add .
git commit -m "feat: deskripsi singkat perubahan"
```

5. Push ke fork:

```bash
git push origin feat/nama-fitur-anda
```

6. Buat Pull Request (PR) ke main repository.

* Reviewer akan meninjau dan memberikan masukan bila perlu.
* Pastikan kamu sudah menarik update terbaru dari `upstream/main` sebelum membuat PR untuk mengurangi konflik.

---

## 📄 Aturan & Pedoman

Sebelum commit / PR, ikuti pedoman ini agar kontribusi konsisten dan mudah direview:

* Gunakan `dart format` untuk format kode.
* Jalankan `flutter analyze` dan perbaiki issue penting.
* Ikuti konvensi penamaan branch: `feat/`, `fix/`, `chore/`, dsb.
* Tulis deskripsi PR yang jelas: jelaskan apa yang berubah dan kenapa.
* Tambahkan tests jika fitur baru mengandung logika penting.

---

## Tips & Catatan

* Untuk menguji integrasi dengan backend lokal, gunakan tunneling (mis. ngrok) atau sesuaikan `baseUrl` pada `ApiService`.
* Jika menggunakan plugin notifikasi atau permission, pastikan menambahkan permission yang diperlukan di `AndroidManifest.xml` dan konfigurasi iOS sebelum build release.

---

