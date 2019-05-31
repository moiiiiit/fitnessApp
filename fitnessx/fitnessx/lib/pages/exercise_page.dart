import 'package:flutter/material.dart';
import '../widgets/progress.dart';
import '../widgets/exercise.dart';

class ExercisePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return(
      Container(
        child:
            Progress()
      )
    );
  }
}