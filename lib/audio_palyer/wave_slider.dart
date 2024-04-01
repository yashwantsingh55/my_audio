import 'dart:math';

import 'package:flutter/material.dart';

/*
wave: (x,t,a) => a*sin(x*0.3-t*0.3)*sin(x*0.3+t*0.3)

Here, x = Bar Count as X-axis
      t = Time
      a = Amplitude of Wave
 
*/

class WaveSlider extends StatefulWidget {
  final double height, width, boxSpace, sliderValue;
  final int division;
  final double Function(int x, double t, double a)? wave;
  final bool fullBoxFill, detectGesture;
  final Function(double sliderValue) onChanged;
  final List<Color> fillColors, emptyColors;

  const WaveSlider({
    super.key,
    required this.sliderValue,
    required this.onChanged,
    this.height = 50,
    this.width = double.infinity,
    this.division = 10,
    this.boxSpace = 0.3,
    this.wave,
    this.fullBoxFill = true,
    this.detectGesture = true,
    this.fillColors = const [Colors.red],
    this.emptyColors = const [Colors.blue],
  });

  @override
  _WaveSliderState createState() => _WaveSliderState();
}

class _WaveSliderState extends State<WaveSlider> {
  double _time = 0, _width = 0;

  void _sliderTap(TapUpDetails details) {
    if (!widget.detectGesture) return;
    final newValue = details.localPosition.dx / _width;
    widget.onChanged(newValue);
  }

  void _hDragUpdate(DragUpdateDetails details) {
    if (!widget.detectGesture) return;
    final newValue = (details.localPosition.dx) / _width;
    widget.onChanged(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (c, size) {
        final w = widget.width.isFinite ? widget.width : size.maxWidth;
        _width = w;
        final h = widget.height;
        final bww = w / widget.division;
        final bs = (bww * widget.boxSpace) / 2;
        final passIndex = (widget.sliderValue * widget.division).floor();
        final bw = bww - bs * 2;
        final l1 = widget.fillColors.length;
        final l2 = widget.emptyColors.length;
        return GestureDetector(
          onTapUp: _sliderTap,
          onHorizontalDragUpdate: _hDragUpdate,
          child: Container(
            color: Colors.transparent,
            height: h,
            width: w,
            child: Row(
              children: List.generate(widget.division, (index) {
                return Container(
                  margin: EdgeInsets.only(left: bs, right: bs),
                  width: bw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: index < passIndex
                        ? widget.fillColors[index % l1]
                        : widget.emptyColors[index % l2],
                  ),
                  height: widget.wave == null
                      ? sin(index).abs() * h
                      : widget.wave!(index, _time, h).abs(),
                  child: index == passIndex && !widget.fullBoxFill
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: ((w * widget.sliderValue) - (index * bww)),
                            color: Colors.red,
                          ),
                        )
                      : null,
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
