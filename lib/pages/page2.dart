import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontFamily: 'Pacifico',
      color: Colors.white
    );
    const labelStyle = TextStyle(
      fontFamily: 'JuliusSansOne',
      color: Colors.white,
      fontSize: 18
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

          FormPerson(labelStyle: labelStyle, textStyle: textStyle)
        ]
      ),
    );
  }
}

class FormPerson extends StatefulWidget {
  const FormPerson({
    super.key,
    required this.labelStyle,
    required this.textStyle,
  });

  final TextStyle labelStyle;
  final TextStyle textStyle;

  @override
  State<FormPerson> createState() => _FormPersonState();
}

class _FormPersonState extends State<FormPerson> {
  final _formKey = GlobalKey<FormState>();
  final _person1Controller = TextEditingController();
  final _person2Controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _person1Controller.dispose();
    _person2Controller.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 65, vertical: 0),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text('Person 1', style: widget.labelStyle),
                      ),
                      InputPerson(
                        index: 1, controller: _person1Controller,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 17, bottom: 15),
                        child: Text('loves', style: widget.textStyle.copyWith(fontSize: 22)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text('Person 2', style: widget.labelStyle),
                      ),
                      InputPerson(
                        index: 2, controller: _person2Controller,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 75),
            child: GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  // sembunyikan keypad
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  final full = (_person1Controller.text + _person2Controller.text).toLowerCase();
                  var total = 0;
                  for (var i = 0; i < full.length; i++) {
                    total += full.codeUnitAt(i);
                  }
                  final result = total % 101;
                  final snackBar = SnackBar(content: Text('Hasilnya Adalah: $result'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 65, vertical: 0),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xffbb1f50), Color(0xffe95d83)
                    ]
                  ),
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [ BoxShadow(
                    color: Colors.white.withAlpha(60),
                    blurRadius: 7,
                    spreadRadius: 2
                  )]
                ),
                child: Center(
                  child: Text('Calculate', style: widget.textStyle.copyWith(fontSize: 20))
                ),
              ),
            ),
          )
        ],
      ),  
    );
  }
}


class InputPerson extends StatefulWidget {
  const InputPerson({
    Key? key,
    required this.index,
    required this.controller
  }) : super(key: key);
  
  final int index;
  final TextEditingController controller;

  @override
  _InputPersonState createState() => _InputPersonState();
}

class _InputPersonState extends State<InputPerson> {
  late FocusNode _focusNode;

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    const inputStyle = TextStyle(
      fontFamily: 'JuliusSansOne',
      fontSize: 16, 
      color: Color(0xff55021e),
      fontWeight: FontWeight.bold
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: _focusNode.hasFocus ? Colors.white : Colors.transparent,
            blurRadius: 7, spreadRadius: 1
          )
        ]
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Person ${widget.index} must be not empty';
          }
          return null;
        },
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        style: inputStyle,
        focusNode: _focusNode,
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          hintStyle: inputStyle,
          hintText: 'Person ${widget.index}',
          fillColor: _focusNode.hasFocus ? Color(0xfff3e3f5) : Color(0xffdea8d0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.transparent)
          )
        ),
      ),
    );
  }
}