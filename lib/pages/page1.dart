import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontFamily: 'Pacifico',
      fontSize: 40
    );

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffb81d46), Color(0xff804ad9)]
        )
      ),
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Opacity(
            opacity: 0.1,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 450,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/heart.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          Center(
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'The', style: textStyle),
                  TextSpan(text: "\nLOVE\n", style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 70, fontWeight: FontWeight.w900,
                    height: 0.8
                  )),
                  TextSpan(text: 'Calculator', style: textStyle.copyWith(
                    height: 1
                  ))
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}
