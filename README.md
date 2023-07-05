<h1 align="center">Single Import Generator</h1>
<p align="center"><img src="https://github.com/Xim-ya/single_import_generator/assets/75591730/611e68bf-abbe-4dff-8e20-03b8073728d6"/></p>
<p align="center">Single Import Generator is a Dart package that provides a command-line tool for generating import index files for your Dart projects. With a single import statement, easily manage and organize multiple files within your project, increasing productivity and improving code readability.</p><br>

<p align="center">
  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter"
      alt="Platform" />
  </a>
  <a href="">
    <img src="https://img.shields.io/pub/v/single_import_generator"
      alt="Pub Package"/>
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/github/license/aagarwal1012/animated-text-kit?color=red"
      alt="License: MIT" />
  </a>


</p><br>    



# Key Features

* 🔑 Easy to use
* 🗂️ Enhanced code organization
* ⏰ Save time and effort by eliminating the need to write repetitive import statements for multiple files.

<br/>


# Installing

To use the Single Import Generator package in your Flutter project, follow these steps:

1. Depend on it

Add the following line to your project's `pubspec.yaml` file under the `dependencies` section:

```yaml
dependencies:
  single_import_generator: ^1.0.0
```

2. Install it

Run the following command in your terminal or command prompt:

```
$ flutter pub get
```


3. Generate Import Index 

Generate a Import Index statement using the command-line tool. Check the details below.


<br/>


# Usage - Command-Line Tool
Single Import Generator provides command-line tools to simplify your development workflow and generate import index files for your Dart projects. These index files consolidate multiple `export` statements into a single import, improving code organization and readability.

 

### 1. Generating Import Index Files for a Target Directory

You can use the following command to generate an index file, known as a "barrel" file, containing export statements for all Dart files in a target directory
```bash
$ dart run single_import_generator -target=<target_directory> all
```
##### [Example]
<img src="https://github.com/Xim-ya/single_import_generator/assets/75591730/fabf160f-7237-4442-9898-57f611e020db"/>

```bash
$ dart run single_import_generator -target=lib/presentation all
```

This command scans all Dart files in the specified target directory and its subdirectories, and generates an index.dart file. The index.dart file contains export statements for all the Dart files, enabling you to import them using a single import statement.




<br/>


### 2. Generating Import Index Files for a Single Directory

If you want to generate an index file for a single directory, excluding its subdirectories, you can use the following command.
```bash
$ dart run single_import_generator -target=<target_directory> dir
```

##### [Example]
<img src="https://github.com/Xim-ya/single_import_generator/assets/75591730/d53c45c5-6c37-4d5b-9614-e947aefa491c"/>

```bash
$ dart run single_import_generator -target=lib/presentation/common dir
```
Similarly, a barrel file named index.dart is generated in the specified directory, allowing you to import multiple files from that directory with a single import statement.

<br/>

### 3. Generating Import Index Files with @SingleImport Annotation
In addition to generating import index files for directories, you can also use the @SingleImport() annotation to generate an index file that includes export statements for all Dart files in the same directory. This can be done using the following command:


```bash
$ dart run single_import_generator -path=<target_directory>
```
```dart
import 'package:single_import_generator/single_import_generator.dart';

@SingleImport 
class SomeClass {
  ...
}
```
Here, <target_directory> represents the path where the index.dart file will be generated. It specifies the directory where the export statements will be consolidated into the index.dart file.

##### [Example]


<img src="https://github.com/Xim-ya/single_import_generator/assets/75591730/9052e1f6-d4c6-4a10-bee9-3a1060e04ade"/>

```bash
$ dart run single_import_generator -path=lib/utilities
```

When you annotate a class or a file with @SingleImport(), you are indicating that the file is responsible for managing the export statements using the Single Import Generator. The generator will scan all the Dart files in the specified directory and its subdirectories. It will then generate an index.dart file in the specified directory, which includes export statements for all the scanned files.

```dart
/* libraries */
export 'package:flutter/material.dart';
export 'package:provider/provider.dart';

export 'package:projectName/presentation/a_class.dart';
export 'package:projectName/domain/b_class.dart';
```

You can include commonly used packages or libraries by adding the respective import statements to the annotated files. For example, you can add the following line to include the material package.

> These package imports will be retained in the generated index.dart file, even when you run the generator again. This allows you to easily manage and organize your imports, including both project-specific files and commonly used packages.

<br/>

These command-line tools help you streamline your import statements and keep your project organized. By utilizing Single Import Generator, you can enjoy a more efficient development experience and improved code maintainability.

Feel free to customize and expand on this information based on the specific features and functionality of Single Import Generator.



 

