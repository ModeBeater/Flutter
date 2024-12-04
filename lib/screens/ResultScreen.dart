import 'package:flutter/material.dart';
import '../gameLogic/game_bloc.dart';

class ResultScreen extends StatelessWidget {
  final GameBloc gameBloc;
  final String title;
  final String result;
  Color color = Colors.red;
  ResultScreen({required this.result, required this.title,required this.gameBloc}){
    if (title == 'Поражение'){
      color = Colors.red;
    }
    else{
      color = Colors.green;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result,

                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                  gameBloc.add(ResetGame());
                }, child: Text("Начать заново"))
          ],
        ),
      ),
    );
  }

}