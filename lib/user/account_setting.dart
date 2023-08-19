// import 'package:flutter/material.dart';
// import 'package:magicomputer/auth/login.dart';

// class AccountSetting extends StatelessWidget {
//   const AccountSetting({super.key});

//   void _logout(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Logout Confirmation'),
//           content: const Text('Are you sure you want to logout?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Tutup dialog
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginPage()),
//                   (route) => false,
//                 );
//               },
//               child: const Text('Logout'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: <Color>[
//                 Color.fromARGB(255, 19, 36, 60),
//                 Color.fromARGB(255, 43, 21, 54)
//               ])),
//         ),
//         title: const Text('Account Setting'),
//       ),
//       body: ListView.builder(
//         itemCount: 2, // Jumlah daftar akun dan privasi
//         itemBuilder: (BuildContext context, int index) {
//           if (index == 0) {
//             return ListTile(
//               title: const Row(
//                 children: [
//                   Expanded(
//                     child: Text('Akun dan Privasi'),
//                   ),
//                   Icon(
//                     Icons.chevron_right,
//                     color: Colors.black,
//                   ),
//                 ],
//               ),
//               onTap: () {
//                 // Navigasi ke halaman pengaturan akun
//               },
//             );
//           } else if (index == 1) {
//             return ListTile(
//               title: const Row(
//                 children: [
//                   Expanded(
//                     child: Text('Alamat'),
//                   ),
//                   Icon(
//                     Icons.chevron_right,
//                     color: Colors.black,
//                   ),
//                 ],
//               ),
//               onTap: () {
//                 // Navigasi ke halaman pengaturan privasi
//               },
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _logout(context); // Panggil metode logout
//         },
//         child: const Icon(Icons.logout),
//       ),
//     );
//   }
// }
