import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/text_view.dart';

class TherapyScreen extends StatefulWidget {
  const TherapyScreen({Key? key}) : super(key: key);

  @override
  State<TherapyScreen> createState() => _TherapyScreenState();
}

class _TherapyScreenState extends State<TherapyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: TextView(
          text: 'Therapy',
          style:
              GoogleFonts.fraunces(fontSize: 32, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
