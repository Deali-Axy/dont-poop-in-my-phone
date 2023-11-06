import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:flutter/material.dart';

class CleanPage extends StatefulWidget {
  const CleanPage({Key? key}) : super(key: key);

  @override
  _CleanPageState createState() => _CleanPageState();
}

class _CleanPageState extends State<CleanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('自动清理')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StorageMeter()
        ],
      ),
    );
  }
}
