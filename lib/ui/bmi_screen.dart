import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  double? bmi;
  String category = "";

  void calculateBMI() {
    final heightCm = double.tryParse(heightController.text);
    final weightKg = double.tryParse(weightController.text);

    if (heightCm != null && weightKg != null && heightCm > 0) {
      final heightM = heightCm / 100;
      final value = weightKg / (heightM * heightM);
      setState(() {
        bmi = value;
        if (value < 18.5) {
          category = "Underweight";
        } else if (value < 25) {
          category = "Normal";
        } else if (value < 30) {
          category = "Overweight";
        } else {
          category = "Obese";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF203A43),
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _inputField("Height (cm)", heightController),
              const SizedBox(height: 16),
              _inputField("Weight (kg)", weightController),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                ),
                onPressed: calculateBMI,
                child: const Text("Calculate BMI"),
              ),
              const SizedBox(height: 24),
              if (bmi != null)
                Column(
                  children: [
                    Text("Your BMI", style: _labelStyle()),
                    Text(
                      bmi!.toStringAsFixed(1),
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.amberAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  TextStyle _labelStyle() =>
      GoogleFonts.poppins(fontSize: 18, color: Colors.white70);
}
