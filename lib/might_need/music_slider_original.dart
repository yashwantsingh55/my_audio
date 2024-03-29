import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

/// Used To Control MusicSlider
class MusicSliderController {
  double _value = 0;
  void Function(double value)? _onSliderChange, _onSliderStart, _onSliderEnd;
  void Function(bool value)? _animateByTime;
  void Function()? _attachedSlider;

  /// Value of slider ( in range of 0 - 1 )
  double get value => _value;

  /// Change the Value of slider ( in range of 0 - 1 )
  void seekTo(double val) {
    val = val.clamp(0.0, 1.0);
    if (_attachedSlider == null) {
      throw Exception("MusicSliderController Not Attached To any MusicSlider");
    }
    _value = val;
    _attachedSlider!();
    if (_onSliderChange != null) {
      _onSliderChange!(_value);
    }
  }

  /// Control Animation Start/Stop
  void animateByTime(bool val) {
    if (_animateByTime == null) {
      return;
    }
    _animateByTime!(val);
  }

  /// Callback Called when MusicSlider Change value
  void onSliderChange(void Function(double) func) {
    _onSliderChange = func;
  }

  /// Callback Called when MusicSlider Change Start
  void onSliderStart(void Function(double) func) {
    _onSliderStart = func;
  }

  /// Callback Called when MusicSlider Change End
  void onSliderEnd(void Function(double) func) {
    _onSliderEnd = func;
  }

  /// Constructor
  MusicSliderController({double initialValue = 0.0}) {
    _value = initialValue;
  }
}

/// MusicSlider Class To Create Wavy SeekBar
class MusicSlider extends StatefulWidget {
  /// Height, Width, Space Between Boxes, Initial Time
  final double? height, width, boxSpace, initialTime;

  /// Division
  final int division;

  /// Wave Function
  final double Function(int x, double t, double a)? wave;

  /// tickCount ( like Count of frame )
  final Duration tickCount;

  /// animateWaveByTime, fullBoxFill, detectGesture
  final bool animateWaveByTime, fullBoxFill, detectGesture;

  /// Controller
  final MusicSliderController controller;

  /// Colors
  final List<Color> fillColors, emptyColors;

  /// Constructor
  const MusicSlider({
    super.key,
    required this.controller,
    this.height,
    this.width,
    this.division = 10,
    this.boxSpace = 0.3,
    this.wave,
    this.animateWaveByTime = true,
    this.tickCount = const Duration(milliseconds: 200),
    this.fullBoxFill = true,
    this.detectGesture = true,
    this.fillColors = const [Colors.red],
    this.emptyColors = const [Colors.blue],
    this.initialTime = 0.0,
  });

  @override
  _MusicSliderState createState() => _MusicSliderState();
}

class _MusicSliderState extends State<MusicSlider> {
  double _time = 0, _width = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    _time = widget.initialTime ?? 0.0;

    if (widget.controller._attachedSlider != null) {
      throw Exception(
          "One MusicSliderController Can Attach To Only One MusicSlider");
    }

    widget.controller._attachedSlider = () {
      setState(() {});
    };
    widget.controller._animateByTime = (val) {
      if (_timer != null) {
        _timer!.cancel();
      }
      if (val) {
        _timer = Timer.periodic(widget.tickCount, (timer) {
          setState(() {
            _time++;
          });
        });
      }
    };

    if (_timer != null) {
      _timer!.cancel();
    }
    if (widget.animateWaveByTime) {
      _timer = Timer.periodic(widget.tickCount, (timer) {
        setState(() {
          _time++;
        });
      });
    }
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    initialize();
    super.didUpdateWidget(oldWidget);
  }

  void _sliderTap(TapUpDetails details) {
    if (!widget.detectGesture) {
      return;
    }
    widget.controller.seekTo(details.localPosition.dx / _width);
  }

  void _hDragStart(DragStartDetails details) {
    if (!widget.detectGesture) {
      return;
    }
    if (widget.controller._onSliderStart == null) {
      return;
    }
    widget.controller._onSliderStart!(widget.controller.value);
  }

  void _hDragUpdate(DragUpdateDetails details) {
    if (!widget.detectGesture) {
      return;
    }
    widget.controller.seekTo(((details.localPosition.dx) / _width));
  }

  void _hDragEnd(DragEndDetails details) {
    if (!widget.detectGesture) {
      return;
    }
    if (widget.controller._onSliderEnd == null) {
      return;
    }
    widget.controller._onSliderEnd!(widget.controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (c, size) {
        double w = widget.width != null ? widget.width! : size.maxWidth;
        _width = w;
        double h =
            widget.height != null ? widget.height! : size.maxHeight ?? 50;
        double bww = w / widget.division;
        double bs = (bww * widget.boxSpace!) / 2;
        int passIndex = (widget.controller.value * widget.division).floor();
        double bw = bww - bs * 2;
        int l1 = widget.fillColors.length;
        int l2 = widget.emptyColors.length;
        return GestureDetector(
          onTapUp: _sliderTap,
          onHorizontalDragStart: _hDragStart,
          onHorizontalDragUpdate: _hDragUpdate,
          onHorizontalDragEnd: _hDragEnd,
          child: Container(
            color: Colors.transparent,
            height: h,
            width: w,
            child: Row(
              children: List.generate(widget.division, (index) {
                return Container(
                  decoration: BoxDecoration(
                      color: index < passIndex
                          ? widget.fillColors[index % l1]
                          : widget.emptyColors[index % l2],
                      borderRadius: BorderRadius.circular(5)),
                  margin: EdgeInsets.only(left: bs, right: bs),
                  width: bw,
                  height: widget.wave == null
                      ? sin(index).abs() * h
                      : widget.wave!(index, _time, h).abs(),
                  child: index == passIndex && !widget.fullBoxFill
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width:
                                ((w * widget.controller.value) - (index * bww)),
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
