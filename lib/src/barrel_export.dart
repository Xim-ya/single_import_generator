import 'dart:io';


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
