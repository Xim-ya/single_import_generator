import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

class AnnotationIndexGenerator {
  final List<String> exportStatements = [];

  void generateExportIndex(String outputDirectory) {
    final targetDirectory = Directory('lib');

    if (!targetDirectory.existsSync()) {
      print('Directory not found: lib');
      return;
    }

    // Load the project name from the yaml file
    final yamlFile = File('pubspec.yaml');
    final yamlContent = yamlFile.readAsStringSync();
    final yaml = loadYaml(yamlContent);
    final projectName = yaml['name']; // get projectName

    final indexFilePath = path.join(outputDirectory, 'index.dart');
    final indexFile = File(indexFilePath);

    // If there is a previously saved index.dart file, read it to retrieve existing export statements.
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
                  path.join('package:$projectName', currentPath, fileName);
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

    // Combine the existing export statements with the new export statements.
    final allExportStatements = [
      ...existingExportStatements,
      ...exportStatements
    ];

    // Remove duplicate export statements.
    final uniqueExportStatements = allExportStatements.toSet().toList();

    final addedCount = exportStatements.length;

    // Remove unused modules.
    final filteredExportStatements = uniqueExportStatements.where((statement) {
      if (statement.startsWith('export \'package:$projectName/')) {
        final packageName = statement.split('\'')[1].split('/').last;
        return exportStatements
            .any((exportStatement) => exportStatement.contains(packageName));
      }
      return true;
    }).toList();

    try {
      indexFile.writeAsStringSync(filteredExportStatements.join('\n'));
      print(
          'Index file generated successfully at: $indexFilePath [$addedCount export file(s) managed]');
    } catch (e) {
      print('Error writing to file: $e');
    }
  }
}
