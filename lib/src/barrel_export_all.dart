import 'dart:io';

void exportAll(String targetDirectory) {
  final directory = Directory(targetDirectory);

  if (!directory.existsSync()) {
    print('Directory not found: $targetDirectory');
    return;
  }

  final files = directory.listSync().whereType<File>().where((file) => file.path.endsWith('.dart'));

  final indexFile = File('${directory.path}/index.dart');
  final exports = files.map((file) => "export '${file.path.split('$targetDirectory/').last}';");
  indexFile.writeAsStringSync(exports.join('\n'));

  print('Created index.dart in $targetDirectory');
}
