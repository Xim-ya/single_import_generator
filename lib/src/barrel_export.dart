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
      abbr: 't', help: '대상 디렉토리를 지정하세요', valueHelp: 'directory');

  final argResults = parser.parse(arguments);
  final targetDirectory = argResults['target'] as String?;

  if (targetDirectory == null) {
    print('대상 디렉토리를 -t 또는 --target 옵션으로 지정해주세요.');
    return;
  }

  exportDirectory(targetDirectory);
}
