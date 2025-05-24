import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _glassCard(
                  context,
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/avator3.jpg'), // or NetworkImage
                      ),
                      const SizedBox(height: 12),
                      Text("Fahmi D", style: _whiteText(18, FontWeight.bold)),
                      Text("fahmi@example.com", style: _whiteText(14, FontWeight.w300)),
                      const SizedBox(height: 8),
                      Text("Age: 21   |   Gender: Male", style: _whiteText(13, FontWeight.w300)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                _glassCard(
                  context,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title("Device Info"),
                      const SizedBox(height: 8),
                      _infoRow("Device ID", "watch123"),
                      _infoRow("Status", "Connected", color: Colors.greenAccent),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                _glassCard(
                  context,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title("Latest Vitals"),
                      _infoRow("Heart Rate", "78 bpm"),
                      _infoRow("Temperature", "36.8 °C"),
                      _infoRow("SpO₂", "98%"),
                      _infoRow("Blood Pressure", "120/80"),
                    ],
                  ),
                ),
                const Spacer(),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    // Add logout logic here
                    Navigator.pop(context);
                  },
                  child: const Text("Logout"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _glassCard(BuildContext context, {required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: _whiteText(14, FontWeight.w400)),
          Text(value, style: TextStyle(fontSize: 14, color: color ?? Colors.white)),
        ],
      ),
    );
  }

  Widget _title(String title) {
    return Text(title, style: _whiteText(16, FontWeight.bold));
  }

  TextStyle _whiteText(double size, FontWeight weight) {
    return GoogleFonts.poppins(fontSize: size, fontWeight: weight, color: Colors.white);
  }
}
