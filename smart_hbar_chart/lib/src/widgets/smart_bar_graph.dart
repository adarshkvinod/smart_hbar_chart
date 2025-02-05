import 'package:flutter/material.dart';

import '../models/bar_data.dart';
import '../models/bar_style.dart';

class SmartBarGraph extends StatefulWidget {
  final List<SmartBarData> data;
  final int maxValue;
  final SmartBarStyle style;
  final Widget Function(String imageUrl)? imageBuilder;

  const SmartBarGraph({
    Key? key,
    required this.data,
    required this.maxValue,
    this.style = const SmartBarStyle(),
    this.imageBuilder,
  }) : super(key: key);

  @override
  State<SmartBarGraph> createState() => _SmartBarGraphState();
}

class _SmartBarGraphState extends State<SmartBarGraph>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _barAnimations;
  late double maxWidth;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.style.animationDuration,
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    maxWidth = MediaQuery.of(context).size.width - 16;
    _initializeAnimations();
    _controller.forward();
  }

  void _initializeAnimations() {
    _barAnimations = widget.data.map((data) {
      double targetWidth = _calculateWidth(data.value);
      return Tween<double>(begin: 0, end: targetWidth).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );
    }).toList();
  }

  double _calculateWidth(double value) {
    if (widget.maxValue == 0) return 0;
    double percentage = (value / widget.maxValue) * 100;
    return (percentage / 100) * maxWidth;
  }

  Widget _buildImage(String imageUrl) {
    if (widget.imageBuilder != null) {
      return widget.imageBuilder!(imageUrl);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.style.barBorderRadius),
      child: Image.network(
        imageUrl,
        height: widget.style.imageSize,
        width: widget.style.imageSize,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRuler(),
        _buildBars(),
      ],
    );
  }

  Widget _buildRuler() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('0KG', style: widget.style.valueTextStyle),
        Text('${widget.maxValue}KG', style: widget.style.valueTextStyle),
      ],
    );
  }

  Widget _buildBars() {
    return Padding(
      padding: widget.style.padding,
      child: Column(
        children: List.generate(
          widget.data.length,
          (index) => _buildBar(index),
        ),
      ),
    );
  }

  Widget _buildBar(int index) {
    return Padding(
      padding: EdgeInsets.only(top: index != 0 ? 4 : 0),
      child: Stack(
        children: [
          _buildBarBackground(),
          _buildAnimatedBarFill(index),
          _buildBarContent(index),
        ],
      ),
    );
  }

  Widget _buildBarBackground() {
    return Container(
      height: widget.style.barHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.style.barBorderRadius),
        color: widget.style.backgroundColor,
      ),
    );
  }

  Widget _buildAnimatedBarFill(int index) {
    return AnimatedBuilder(
      animation: _barAnimations[index],
      builder: (context, child) => Container(
        height: widget.style.barHeight,
        width: _barAnimations[index].value,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.style.barGradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(widget.style.barBorderRadius),
          ),
        ),
      ),
    );
  }

  Widget _buildBarContent(int index) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildImage(widget.data[index].imageUrl),
              const SizedBox(width: 6),
              Text(
                widget.data[index].label,
                style: widget.style.labelTextStyle,
              ),
            ],
          ),
          Text(
            '${widget.data[index].value} KG',
            style: widget.style.valueTextStyle,
          ),
        ],
      ),
    );
  }
}
