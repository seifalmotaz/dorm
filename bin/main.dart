import 'dart:io';
import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dorm/dorm.dart';
import 'package:path/path.dart';

Future<List<String>> getDartFiles(String directoryPath) async {
  final directory = Directory(directoryPath);
  final entities = directory.list(recursive: true); // Include subdirectories

  return await entities
      .where((file) => file is File && file.path.endsWith('.db.dart'))
      .map((event) => context.absolute(context.normalize(event.path)))
      .cast<String>()
      .toList();
}

Future<void> main() async {
  List<String> includedPaths = await getDartFiles('./');
  AnalysisContextCollection collection =
      AnalysisContextCollection(includedPaths: includedPaths);
  analyzeSomeFiles(collection, includedPaths);
}

void analyzeSomeFiles(
  AnalysisContextCollection collection,
  List<String> includedPaths,
) {
  for (String path in includedPaths) {
    AnalysisContext context = collection.contextFor(path);
    analyzeSingleFile(context, path);
  }
}

Future<void> analyzeSingleFile(AnalysisContext context, String path) async {
  AnalysisSession session = context.currentSession;
  var result = await session.getUnitElement(path);
  if (result is UnitElementResult) {
    CompilationUnitElement element = result.element;
    parseModels(element);
  }
}
