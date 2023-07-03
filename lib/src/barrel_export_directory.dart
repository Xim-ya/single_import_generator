import 'dart:io';
import 'package:args/args.dart';

void exportDirectory(String targetDirectory) {
  var directory = Directory(targetDirectory);
  var files = directory.listSync();

  var exportCode = '';

  for (var file in files) {
    if (file is File && file.path.endsWith('.dart')) {
      var fileName = file.uri.pathSegments.last;
      exportCode += "export '$fileName';\n";
    }
  }

  var indexFile = File('$targetDirectory/index.dart');
  indexFile.writeAsStringSync(exportCode);
}

void main(List<String> arguments) {
  final parser = ArgParser();
  parser.addOption('target',
      abbr: 't', help: 'Specify the target directory', valueHelp: 'directory');

  final argResults = parser.parse(arguments);
  final targetDirectory = argResults['target'] as String?;

  if (targetDirectory == null) {
    print('Please specify the target directory using -t or --target option.');
    return;
  }

  exportDirectory(targetDirectory);
}
