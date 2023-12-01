import 'dart:io';

// Short lil function for reading in from file 
// and splitting based on newline
// (Pretty common AoC thing)
List<String> read_in_file (String filepath) {
  var inputFile = File(filepath);

  List<String> readIn = [];
  readIn = inputFile.readAsLinesSync();

  return readIn;

}
