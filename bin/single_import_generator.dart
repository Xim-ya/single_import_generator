import 'package:single_import_generator/src/barrel_export.dart';

void main(List<String> arguments) {
  String? directory;
  bool includeSubdirectories = true;

  for (final arg in arguments) {
    if (arg.startsWith('-target=')) {
      directory = arg.substring(8);
    } else if (arg == 'all') {
      includeSubdirectories = true;
    } else if (arg == 'dir') {
      includeSubdirectories = false;
    }
  }

  if (directory == null) {
    print('Please provide the target directory using -target option.');
    return;
  }

  try {
    generateIndex(directory, includeSubdirectories: includeSubdirectories);
  } catch (e) {
    print('An error occurred: $e');
  }
}
