import 'package:flutter/material.dart';

import 'package:Autoroom/theme.dart';
import 'package:firebase_database/firebase_database.dart';


class NeoPixels extends StatefulWidget {
  NeoPixels({Key key}) : super(key: key);

  _NeoPixelsState createState() => _NeoPixelsState();
}

class _NeoPixelsState extends State<NeoPixels> {
  
  final database = FirebaseDatabase.instance.reference();
  final npIDController = TextEditingController();
  double hueGlobal = 0;
  double saturationGlobal = 0;
  double valueGlobal = 0;
  String ledID = "0";
  bool updateState = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    npIDController.dispose();
    super.dispose();
  }

  //Other Manipulation Functions

      //UPDATE HSV value
      void _updateHue(double hue){
        setState(() {
          hueGlobal = hue; 
        });
      }
      void _updateSaturation(double saturation){
        setState(() {
          saturationGlobal = saturation; 
        });
      }
      void _updateValue(double value){
        setState(() {
          valueGlobal = value; 
        });
      }
      void _updateLedID(text){
        setState(() {
          updateState=false;
          ledID = text; 
        });
      }

  void _setColor(){
    setState(() {
      // To link with database .then callback
      updateState=true; 
    });
    Color c = HSVColor.fromAHSV(1, hueGlobal, saturationGlobal, valueGlobal).toColor();
    print(c.blue);
    print(c.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
       child: Container(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           mainAxisSize: MainAxisSize.max,
           children: <Widget>[
               
            Container(
              padding: EdgeInsets.all(100),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HSVColor.fromAHSV(1, hueGlobal, saturationGlobal, valueGlobal).toColor(),
                ),
              ),

            Padding(padding: EdgeInsets.all(20),),

            Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                Container(
                  width: 200, height: 40,
                  child: TextField(
                    textAlign: TextAlign.center,
                    onSubmitted: _updateLedID,
                    controller: npIDController,
                    keyboardType: TextInputType.number, 
                    style: TextStyle(fontSize: 30),),
                 ),
                Padding(padding: EdgeInsets.all(20),),
                 RaisedButton(
                  onPressed: _setColor,
                  color: updateState?Color.fromARGB(255, 248, 167, 255):Colors.white,                  
                  child: Text(
                    updateState?"Updated":"Update "+ledID.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ],
            ),

      
// -----------------Sliders------------------

        Padding(padding: EdgeInsets.all(20),),
            //Hue Slider
            Text("HUE "+hueGlobal.toStringAsFixed(2)),
            SliderTheme(
              data: customSliderTheme(context),
              child: Slider(
                min: 0,
                divisions: 100,
                max: 360,
                value: hueGlobal,
                label: "Hue "+hueGlobal.floor().toStringAsFixed(2),
                onChanged: _updateHue,
               ),
             ),
             
          Padding(padding: EdgeInsets.all(20),),

            //Saturation Slider
            Text("SAT "+saturationGlobal.toStringAsFixed(2)),
            SliderTheme(
              data: customSliderTheme(context),
              child: Slider(
                min: 0,
                divisions: 100,
                max: 1,
                value: saturationGlobal,
                label: "Saturation "+saturationGlobal.toStringAsFixed(2),
                onChanged: _updateSaturation,
               ),
             ),

          Padding(padding: EdgeInsets.all(20),),

            //Value slider
             Text("VAL "+valueGlobal.toStringAsFixed(2)),
             SliderTheme(
              data: customSliderTheme(context),
              child: Slider(
                min: 0,
                divisions: 100,
                max: 1,
                value: valueGlobal,
                label: "Value "+valueGlobal.toStringAsFixed(2),                
                onChanged: _updateValue,
               ),
             ),

           ],
         ),
      ),
    );
  }
}