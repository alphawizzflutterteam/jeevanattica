import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return  CupertinoApp(
      title: _title,
      home: DynamicRangeSliderDemo(),
    );
  }
}

class CupertinoSliderSample extends StatefulWidget {
  const CupertinoSliderSample({Key? key}) : super(key: key);

  @override
  State<CupertinoSliderSample> createState() => _CupertinoSliderSampleState();
}

class _CupertinoSliderSampleState extends State<CupertinoSliderSample> {
  double _currentSliderValue = 0.0;
  String? _sliderStatus;
  TextEditingController userInput = TextEditingController();
  static const min = 0.0;
  static const max = 10.0;
  double low = min;
  double high = max;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: userInput,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
                onChanged: (value) {
                  setState(() {
                    userInput.text = value.toString();
                  });
                },
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  //add prefix icon
                  // prefixIcon: Icon(
                  //   Icons.person_outline_rounded,
                  //   color: Colors.grey,
                  // ),

                  // errorText: "Error",

                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10.0),
                  // ),
                  //
                  // focusedBorder: OutlineInputBorder(
                  //   borderSide:
                  //   const BorderSide(color: Colors.blue, width: 1.0),
                  //   borderRadius: BorderRadius.circular(10.0),
                  // ),
                  // fillColor: Colors.grey,

                  hintText: "Email/Mobile",

                  //make hint text
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),

                  //create lable
                  labelText: 'Email/Mobile',
                  //lable style
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Text(userInput.text.toString()),


            // RangeSlider(
            //
            //   min: min,
            //   max: max,
            //   values: RangeValues(low, high),
            //   onChanged: (values) {
            //     setState((){
            //       low = values.start;
            //       high = values.end;
            //       print("ssss;;"+min.toString());
            //       print(max);
            //     });
            //     print("${double.parse(userInput.text.toString())}");
            //
            //   }
            //
            // ),

            // Display the current slider value.
            // Text('$_currentSliderValue'),
            // CupertinoSlider(
            //   key: const Key('slider'),
            //   value: double.parse(userInput.text),
            //   // This allows the slider to jump between divisions.
            //   // If null, the slide movement is continuous.
            //   divisions: 5,
            //   // The maximum slider value
            //   max: 100,
            //   activeColor: CupertinoColors.systemPurple,
            //   thumbColor: CupertinoColors.systemPurple,
            //   // This is called when sliding is started.
            //   onChangeStart: (double value) {
            //     setState(() {
            //       _sliderStatus = 'Sliding';
            //     });
            //   },
            //   // This is called when sliding has ended.
            //   onChangeEnd: (double value) {
            //     setState(() {
            //       _sliderStatus = 'Finished sliding';
            //     });
            //   },
            //   // This is called when slider value is changed.
            //   onChanged: (double value) {
            //     setState(() {
            //       _currentSliderValue = value;
            //     });
            //   },
            // ),
            // Text(
            //   _sliderStatus ?? '',
            //   style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            //     fontSize: 12,
            //   ),
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState((){
      //     low = 4;
      //     high = max;
      //   }),
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

class DynamicRangeSliderDemo extends StatefulWidget {
  @override
  _DynamicRangeSliderDemoState createState() => _DynamicRangeSliderDemoState();
}

class _DynamicRangeSliderDemoState extends State<DynamicRangeSliderDemo> {
  double min = 0, max = 100;
  RangeValues rangeValues = RangeValues(0, 100);
  TextStyle kTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dynamic Range Slider Demo')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Dynamic Range Slider',
            //       style: kTextStyle,
            //     ),
            //     Text(
            //       '${rangeValues.start.round().toString()} - ${rangeValues.end.round().toString()}',
            //       style: kTextStyle,
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 20,
            ),
            DynamicRangeSlider(
                currentRangeValues: rangeValues,
                min: min,
                max: max,
                onChanged: (RangeValues values) {
                  setState(() {
                    rangeValues = values;
                  });
                },
                onChangeEnd: (RangeValues values) {
                  // When end value reaches max, then increase max value by 50%
                  if (values.end == max) {
                    setState(() {
                      max = max * 1.5;
                    });
                  }
                  // When end value is more than 100 and is less than 50% of the max,
                  // then decrease max value by 50%
                  else if (max > 100 && values.end < max / 2) {
                    setState(() {
                      max = max / 1.5;
                    });
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('min: $min', style: kTextStyle),
                Text('max: $max', style: kTextStyle),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DynamicRangeSlider extends StatelessWidget {
  final Key? key;
  final RangeValues currentRangeValues;
  final double min, max;
  final onChanged, onChangeEnd;

  DynamicRangeSlider({
    this.key,
    required this.currentRangeValues,
    required this.min,
    required this.max,
    required this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: currentRangeValues,
      min: min,
      max: max,
      divisions: 100,
      labels: RangeLabels(
        currentRangeValues.start.round().toString(),
        currentRangeValues.end.round().toString(),
      ),
      onChanged: onChanged, // callback when the range values change
      onChangeEnd: onChangeEnd ??
          null, // callback when the user is done selecting new values
    );
  }
}
