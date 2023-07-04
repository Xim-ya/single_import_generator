import 'dart:io';

void generateIndex(String directory, {bool includeSubdirectories = true}) {
  final targetDirectory = Directory(directory);

  if (!targetDirectory.existsSync()) {
    print('Directory not found: $directory');
    return;
  }

  final indexFilePath = '${targetDirectory.path}/index.dart';
  final exportStatements = [];

  void generateExportStatements(Directory dir) {
    dir.listSync().forEach((file) {
      if (file is File) {
        final fileName = file.path.split('/').last;
        if (fileName.endsWith('.dart') && fileName != 'index.dart') {
          final exportStatement = "export '${file.path.split('$directory/').last}';";
          exportStatements.add(exportStatement);
        }
      } else if (includeSubdirectories && file is Directory) {
        generateExportStatements(file);
      }
    });
  }

  generateExportStatements(targetDirectory);

  final indexFile = File(indexFilePath);
  indexFile.writeAsStringSync(exportStatements.join('\n'));

  print('Created $indexFilePath');
}
