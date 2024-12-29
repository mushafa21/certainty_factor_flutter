import 'package:certainty_factor/question_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rekomendasi Iphone Bekas"),
      ),
      body: SafeArea(child: Center(
        child: ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> QuestionScreen()));
        }, child: Text("Mulai")),
      )),
    );
  }
}
