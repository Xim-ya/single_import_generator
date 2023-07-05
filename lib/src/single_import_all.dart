import 'dart:io';

void generateImportsForAllFiles(String targetPath) {
  final directory = Directory(targetPath);
  final fileList = directory.listSync(recursive: true, followLinks: false);

  final exportStatements = <String>{};

  for (var entity in fileList) {
    if (entity is File &&
        entity.path.endsWith('.dart') &&
        !entity.path.endsWith('index.dart')) {
      final relativePath = entity.path.substring(directory.path.length + 1);
      final exportStatement = "export '$relativePath';";

      exportStatements.add(exportStatement);
    }
  }

  final indexFileContent = exportStatements.join('\n');
  final indexPath = '$targetPath/index.dart';

  File(indexPath).writeAsStringSync(indexFileContent);

  final numExportsAdded = exportStatements.length;
  print(
      'Index file generated successfully at: $indexPath [$numExportsAdded export file(s) added]');
}