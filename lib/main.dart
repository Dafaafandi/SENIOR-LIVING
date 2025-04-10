import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'screens/opening_screen.dart';
import 'screens/home_page.dart';
import 'screens/login_screen.dart';
import 'screens/create_account_screen.dart';
import 'screens/success_screen.dart'; //
import 'screens/schedule/schedule_screen.dart';
import 'screens/health/health_record_screen.dart';
import 'screens/history/history_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'models/schedule_item.dart';

void main() async {
  // Ubah main menjadi async
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan binding siap
  await initializeDateFormatting(
    'id_ID',
    null,
  ); // Inisialisasi format Indonesia

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ScheduleItemAdapter());
  // Open the schedules box
  await Hive.openBox<ScheduleItem>('schedules');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Senior Living',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins', // Contoh jika Anda ingin set font default
      ),
      initialRoute: '/opening',
      routes: {
        '/opening': (context) => const OpeningScreen(),
        '/login': (context) => const LoginScreen(),
        '/create-account': (context) => const CreateAccountScreen(),
        '/success':
            (context) => const SuccessScreen(), // Tambahkan route success
        // Modifikasi route /home
        '/home': (context) {
          // Ekstrak argumen
          final arguments =
              ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>?;
          // Berikan nilai default jika argumen null atau tidak ada
          final String name = arguments?['name'] ?? 'Pengguna';
          final int age = arguments?['age'] ?? 0;
          final String status = arguments?['status'] ?? 'Tidak Diketahui';

          return HomePage(userName: name, userAge: age, healthStatus: status);
        },
        '/schedule': (context) => const ScheduleScreen(),
        '/health': (context) => const HealthRecordScreen(),
        '/history': (context) => const HistoryScreen(),
        '/notification': (context) => const NotificationScreen(),
        '/settings':
            (context) => const SettingsScreen(), // Tambahkan route settings
      },
    );
  }
}
