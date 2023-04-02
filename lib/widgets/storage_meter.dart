import 'package:flutter/material.dart';
import 'package:storage_space/storage_space.dart';

class StorageMeter extends StatefulWidget {
  const StorageMeter({Key? key}) : super(key: key);

  @override
  _StorageMeterState createState() => _StorageMeterState();
}

class _StorageMeterState extends State<StorageMeter> {
  StorageSpace? _storageSpace;

  @override
  void initState() {
    super.initState();
    initStorageSpace();
  }

  void initStorageSpace() async {
    StorageSpace storageSpace = await getStorageSpace(
      lowOnSpaceThreshold: 5 * 1024 * 1024 * 1024, // 2GB
      fractionDigits: 1, // How many digits to use for the human-readable values
    );
    setState(() {
      _storageSpace = storageSpace;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SizedBox(
          height: 200,
          width: 200,
          child: CircularProgressIndicator(
            strokeWidth: 20,
            value: _storageSpace?.usageValue ?? null,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(
              (_storageSpace?.lowOnSpace ?? false) ? Colors.red : Theme.of(context).primaryColor,
            ),
          ),
        ),
        if (_storageSpace == null) ...[
          Text(
            'Loading',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
        if (_storageSpace != null) ...[
          Column(
            children: [
              Text(
                '${_storageSpace?.usagePercent}%',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 10),
              Text('${_storageSpace?.usedSize}/${_storageSpace?.totalSize}'),
            ],
          ),
        ],
      ],
    );
  }
}
