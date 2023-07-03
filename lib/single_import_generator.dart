library single_import_generator;

import 'dart:io';
import 'package:args/args.dart';

void exportDirectory(String targetDirectory) {
  var directory = Directory(targetDirectory);
  var files = directory.listSync();

  var exportCode = '';

  for (var file in files) {
    if (file is File && file.path.endsWith('.dart')) {
      var fileName = file.uri.pathSegments.last;
      exportCode += "export 'src/$fileName';\n";
    }
  }

  var indexFile = File('$targetDirectory/index.dart');
  indexFile.writeAsStringSync(exportCode);
}

void main(List<String> arguments) {
  try {
    final parser = ArgParser();
    parser.addOption('target',
        abbr: 't', help: 'Specify the target directory', valueHelp: 'directory');

    final argResults = parser.parse(arguments);
    final targetDirectory = argResults['target'] as String?;

    if (targetDirectory == null) {
      throw ArgumentError('Please specify the target directory using -t or --target option.');
    }

    exportDirectory(targetDirectory);
  } catch (e) {
    print('An error occurred: $e');
  }
}
