import 'dart:io';

void generateIndex(String directory) {
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
        if (fileName.endsWith('.dart')) {
          final exportStatement = "export '${file.path.split('$directory/').last}';";
          exportStatements.add(exportStatement);
        }
      } else if (file is Directory) {
        generateExportStatements(file);
      }
    });
  }

  generateExportStatements(targetDirectory);

  final indexFile = File(indexFilePath);
  indexFile.writeAsStringSync(exportStatements.join('\n'));

  print('Created $indexFilePath');
}

void main(List<String> arguments) {
  String? directory;

  for (final arg in arguments) {
    if (arg.startsWith('-target=')) {
      directory = arg.substring(8);
      break;
    }
  }

  if (directory == null) {
    print('Please provide the target directory using -target option.');
    return;
  }

  generateIndex(directory);
}