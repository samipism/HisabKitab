// import 'dart:async';

// import 'package:myproject/data.dart';
// import "package:rxdart/rxdart.dart";

// class DataBloc {
//   List<Data> _samip = [];
//   final _dataListStreamController = StreamController<List<Data>>();
//   final _addDataStreamController = StreamController<Data>();

//   Sink<Data> get formData => _addDataStreamController.sink;

//   Stream<List<Data>> get updatedList => _dataListStreamController.stream;
//   DataBloc() {
//     _addDataStreamController.stream.listen((data) {
//       _samip.add(data);
//       _dataListStreamController.add(_samip);
//     });
//   }
// }
