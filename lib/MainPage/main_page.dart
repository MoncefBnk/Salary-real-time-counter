// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _salaireHoraireController = TextEditingController();

  double salaireParSec = 0.0;
  double cpt = 0.0;
  Timer? timer;

  void startCounting() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => updateEarnings());
  }

  void resetCounting() {
    timer?.cancel();
    setState(() {
      salaireParSec = 0.0;
      cpt = 0.0;
    });
  }

  void updateEarnings() {
    setState(() {
      double hourlyWage =
          double.tryParse(_salaireHoraireController.text) ?? 0.0;
      salaireParSec = hourlyWage / 3600;
      cpt = cpt + salaireParSec;
    });
  }

  @override
  void dispose() {
    _salaireHoraireController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salairy Counter"),
      ),
      body: Column(
        children: [
          SizedBox(height: 170),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Please enter your hourly wage',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30.0),

          // snesor Id  textfield
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.lightBlue),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _salaireHoraireController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Salaire Horaire",
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40.0),

          Text(
            cpt.toStringAsFixed(2) + " \$",
            style: TextStyle(fontSize: 35),
          ),
          SizedBox(height: 30.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: startCounting,
                child: Text('Start Counting'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: resetCounting,
                child: Text('Reset Counting'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
