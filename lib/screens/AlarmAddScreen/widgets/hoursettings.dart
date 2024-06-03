import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HourSettings extends StatefulWidget {
  final Function(int) onIndexChanged;
  double itemWidth;

   HourSettings({Key? key, required this.onIndexChanged,required this.itemWidth})
      : super(key: key);

  @override
  State<HourSettings> createState() => _TimeSettingsState();
}

class _TimeSettingsState extends State<HourSettings> {
  final ScrollController _controller = ScrollController();
  
  static int _currentIndex = 0;

  void _handleControllerNotification() {
    // double itemWidth = (MediaQuery.of(context).size.width)/5;

    double offset = _controller.offset + widget.itemWidth;
    int index = (offset / widget.itemWidth).round();
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index-1;
      });
      widget.onIndexChanged(_currentIndex); // Notify parent about the index change
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleControllerNotification);
    
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerNotification);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double itemWidth  = (MediaQuery.of(context).size.width)/5;
    return Container(
      color: Colors.black,
      height: 80,
      child: ListView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: 28,
        itemBuilder: (context, index) {
          double offset = _controller.offset +
             widget.itemWidth*2 ;
          

          int centralIndex = (offset / widget.itemWidth ).round();
          double opacity = 0.4;
          double scale = 1.0;
          if (index == centralIndex) {
            scale = 1.5; // Scale for the central item
            opacity = 1;
          } else if ((centralIndex == index + 1) ||
              (centralIndex == index - 1)) {
            scale = 1.2; // Scale for the items adjacent to the central
            opacity = 0.7;
          }
          return Container(
            width:widget.itemWidth ,
            child: Center(
              child: (index == 1 || index == 0 || index == 27 || index == 26 )
                  ? Text('    ')
                  : Text(
                      index < 12 ? '0${index - 2}' : '${index - 2}',
                      style: TextStyle(
                          fontSize: 39 * scale,
                          color: Colors.white.withOpacity(opacity)),
                    ),
            ),
          );
        },
      ),
    );
  }
}
