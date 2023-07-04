import 'dart:io';
import 'package:path/path.dart' as path;

class IndexGenerator {
  final List<String> exportStatements = [];

  void generateExportIndex(String outputDirectory) {
    final targetDirectory = Directory('lib');

    if (!targetDirectory.existsSync()) {
      print('Directory not found: lib');
      return;
    }

    final indexFilePath = path.join(outputDirectory, 'index.dart');
    final indexFile = File(indexFilePath);

    // 이전에 저장된 index.dart 파일이 있는 경우, 해당 파일을 읽어 기존 export 구문을 가져옵니다.
    final existingExportStatements =
    indexFile.existsSync() ? indexFile.readAsLinesSync() : [];

    void processDirectory(Directory dir, String currentPath) {
      for (var entity in dir.listSync()) {
        if (entity is File) {
          final fileName = path.basename(entity.path);
          if (fileName.endsWith('.dart') && fileName != 'index.dart') {
            final fileContent = entity.readAsStringSync();
            if (fileContent.contains('@SingleImport')) {
              final packagePath =
              path.join('package:soon_sak', currentPath, fileName);
              final exportStatement = "export '$packagePath';";
              exportStatements.add(exportStatement);
            }
          }
        } else if (entity is Directory) {
          final directoryName = path.basename(entity.path);
          final newPath = path.join(currentPath, directoryName);
          processDirectory(entity, newPath);
        }
      }
    }

    processDirectory(targetDirectory, '');

    // 기존의 export 구문과 새로운 export 구문을 합칩니다.
    final allExportStatements = [
      ...existingExportStatements,
      ...exportStatements
    ];

    // 중복된 export 구문을 제거합니다.
    final uniqueExportStatements = allExportStatements.toSet().toList();

    final addedCount = exportStatements.length;

    // 사용하지 않는 모듈을 제거합니다.
    final filteredExportStatements = uniqueExportStatements.where((statement) {
      if (statement.startsWith('export \'package:soon_sak/')) {
        final packageName = statement.split('\'')[1].split('/').last;
        return exportStatements
            .any((exportStatement) => exportStatement.contains(packageName));
      }
      return true;
    }).toList();

    try {
      indexFile.writeAsStringSync(filteredExportStatements.join('\n'));
      print('Single Import Created $indexFilePath [$addedCount is manged]');
    } catch (e) {
      print('Error writing to file: $e');
    }
  }
}
