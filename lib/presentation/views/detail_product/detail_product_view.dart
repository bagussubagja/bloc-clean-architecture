import 'package:flutter/material.dart';

class DetailProductView extends StatefulWidget {
  const DetailProductView({super.key, required this.productId});
  final int productId;

  @override
  State<DetailProductView> createState() => _DetailProductViewState();
}

class _DetailProductViewState extends State<DetailProductView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('ididid ${widget.productId}');
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
