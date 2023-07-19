import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'agenda_list.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Timer(const Duration(seconds: 4),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AgendaListScreen()),);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width*0.8,
                child: const Text("AGENDA APP",textAlign: TextAlign.center,style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 35),),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                  width: size.width*0.9,
                  child: Lottie.asset("assets/animations/phone.json")
              ),
              const SizedBox(height: 20,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text("KNOW WHATS HAPPENING AROUND YOU!",textAlign: TextAlign.center,style: TextStyle(
                    color: Color.fromRGBO(179, 178, 178, 1.0),
                    fontWeight: FontWeight.w900,
                    fontSize: 20),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}