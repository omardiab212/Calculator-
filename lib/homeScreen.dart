import 'package:calculator/palette.dart';
import 'package:flutter/material.dart';

class calculator extends StatefulWidget {
   calculator({super.key});

  @override
  State<calculator> createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  String firstDigit = "" ;

  String secondDigit = "" ;

  String operation = "" ;

  String result = "" ;

  String displayText = "" ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(flex: 3, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(displayText , style: TextStyle(
                    color: white ,
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ) ) ,


            Expanded(flex: 5, child: Row(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 3, child:Column(
                  spacing: 25,

                  children: [
                    Expanded(
                      child: Row(
                        spacing: 16,
                       crossAxisAlignment:CrossAxisAlignment.stretch ,
                        children: [
                          operationButton(label: "A", onClick: onAllClearPress , backgroundColor:lightGrey ,) ,
                          operationButton(icon:Icon(Icons.backspace_outlined , size: 32,) , label: "C", onClick: onClearPress , backgroundColor:lightGrey ,) ,
                          operationButton(label: "/", onClick: onOperationPress  ,) ,

                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        spacing: 16,
                        crossAxisAlignment:CrossAxisAlignment.stretch ,
                        children: [
                          numberButton(label: "7", onClick: onDigitPress , foregroundColor: lightBlue,),
                          numberButton(label: "8", onClick: onDigitPress),
                          numberButton(label: "9", onClick: onDigitPress),

                        ],),
                    ),

                    Expanded(
                      child: Row(
                        spacing: 16,
                        crossAxisAlignment:CrossAxisAlignment.stretch ,
                        children: [
                          numberButton(label: "4", onClick: onDigitPress , foregroundColor: lightBlue,),
                          numberButton(label: "5", onClick: onDigitPress),
                          numberButton(label: "6", onClick: onDigitPress),

                        ],),
                    ),

                    Expanded(
                      child: Row(
                        spacing: 16,
                        crossAxisAlignment:CrossAxisAlignment.stretch ,
                        children: [
                          numberButton(label: "1", onClick:  onDigitPress , foregroundColor: lightBlue,),
                          numberButton(label: "2", onClick: onDigitPress),
                          numberButton(label: "3", onClick: onDigitPress),

                        ],),
                    ),

                    Expanded(
                      child: Row(
                        spacing: 16,
                        crossAxisAlignment:CrossAxisAlignment.stretch ,
                        children: [
                          numberButton(label: "0", onClick: onDigitPress , flex: 4,),
                          numberButton(label: ".", onClick: onDotPress),

                        ],),
                    )
                  ],
                )  ),

                Expanded(flex: 1, child:  Column(
                  spacing: 25,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    operationButton(label: "*", onClick: onOperationPress ,),
                    operationButton(label: "-", onClick: onOperationPress,backgroundColor: blue,),
                    operationButton(label: "+", onClick: onOperationPress , flex: 3,),
                    operationButton(label: "=", onClick: onEqualPress ,backgroundColor: Colors.lightBlue,  flex: 3,),


                ],)),
              ],
            ))
          ],
        ),
      )),
    );


  }


  void onOperationPress(String op){
    if(firstDigit.isEmpty) return ;
    if(operation.isNotEmpty && secondDigit.isNotEmpty){
       onEqualPress("=");
    }
    operation = op ;
    displayText = firstDigit + operation  ;
    setState(() {

    });
  }


  void onDigitPress(String number ){
     if( operation.isEmpty){
       firstDigit = firstDigit + number ;
       displayText = firstDigit ;
     }else{
       secondDigit = secondDigit + number ;
       displayText = firstDigit + operation + secondDigit;
     }
     setState(() {

     });
  }


  void onDotPress(String dot) {
    if (operation.isEmpty) {
      if (!firstDigit.contains(".")) {
        firstDigit += dot;
      }
      displayText = firstDigit;
    } else {
      if (!secondDigit.contains(".")) {
        secondDigit += dot;
      }
      displayText = firstDigit + operation + secondDigit;
    }

    setState(() {});
  }


  void onEqualPress(String equal){
    if(firstDigit.isEmpty && operation.isEmpty && secondDigit.isEmpty) return ;

    switch(operation){
      case "+" : result =  (double.parse(firstDigit) + double.parse(secondDigit)).toString()  ;
          break ;

      case "-" : result =  (double.parse(firstDigit) - double.parse(secondDigit)).toString()  ;
      break ;

      case "*" : result =  (double.parse(firstDigit) * double.parse(secondDigit)).toString()  ;
      break ;

      case "/" : result =  (double.parse(firstDigit) / double.parse(secondDigit)).toString()  ;
      break ;
    }
    result = result.endsWith(".0") ? result.split(".")[0] : result ;
    displayText = result ;
    firstDigit = result ;
    operation = "" ;
    secondDigit = "" ;
    setState(() {

    });

  }


 void onAllClearPress(String ac){
    displayText = "";
    firstDigit = "";
    secondDigit = "";
    result = "";
    operation = "";
    setState(() {

    });
 }


  void onClearPress(String clear) {
    if (operation.isEmpty) {
      if (firstDigit.isNotEmpty) {
        firstDigit = firstDigit.substring(0, firstDigit.length - 1);
      }
      displayText = firstDigit;
    } else if (secondDigit.isNotEmpty)  {
        secondDigit = secondDigit.substring(0, secondDigit.length - 1);
        displayText = firstDigit + operation + secondDigit;
      }else{
      if(operation.isNotEmpty){
        operation = "" ;
        displayText = firstDigit + operation ;

      }
    }
    setState(() {});
  }

}
class operationButton extends StatelessWidget {
  Function(String) onClick;
  int flex;
  String label;
  Color backgroundColor;
  Color foregroundColor;
  Widget? icon;

  operationButton({
    super.key,
    required this.label,
    required this.onClick,
    this.flex = 2,
    this.backgroundColor = blue,
    this.foregroundColor = white,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: FilledButton(
        onPressed: () {
          onClick(label);
        },
        style: FilledButton.styleFrom(
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: icon  ??
            Text(
              label,
              style: TextStyle(
                color: white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
    );
  }
}

class numberButton extends StatelessWidget {
  Function(String ) onClick ;
  int flex ;
  String label ;
  Color backgroundColor   ;
  Color foregroundColor  ;

  numberButton({super.key ,
    required this.label ,
    required this.onClick ,

    this.flex = 2 ,
    this.backgroundColor = grey ,
    this.foregroundColor = lightBlue  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: FilledButton
        (onPressed: (){
          onClick(label);
          print("this is Digit $label");
      },

        style: FilledButton.styleFrom(
            foregroundColor: foregroundColor ,
            backgroundColor: backgroundColor ,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))
        ),
        child: Text(label , style: TextStyle(
          fontSize: 32 ,
          fontWeight: FontWeight.bold ,
        ),) ,

      ),
    );
  }
}






