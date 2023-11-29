// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';


class EmptyScreen extends StatefulWidget {
  const EmptyScreen({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;

  @override
  State<EmptyScreen> createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: widget.color,
      ),
    );
  }
}
