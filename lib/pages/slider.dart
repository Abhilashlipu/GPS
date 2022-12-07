import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double value = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: 
       SliderTheme(
        data: SliderThemeData(
          thumbColor: Colors.green,
          overlayColor: Colors.green.shade200,
          valueIndicatorColor: Colors.green,
    
          /// track color
          activeTrackColor: Colors.green.shade200,
          inactiveTrackColor: Colors.black12,
    
          /// ticks in between
          activeTickMarkColor: Colors.transparent,
          inactiveTickMarkColor: Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Slider(
            //   value: value,
            //   min: 0,
            //   max: 100,
            //   divisions: 10,
            //   label: value.round().toString(),
            //   onChanged: (value) => setState(() => this.value = value),
            // ),
            const SizedBox(height: 100),
            Slider(
              value: value,
              min: 0,
              max: 100,
              divisions: 100,
              activeColor: Colors.red,
              inactiveColor: Colors.red.shade100,
              label: value.round().toString(),
              onChanged: (value) => setState(() => this.value = value),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
