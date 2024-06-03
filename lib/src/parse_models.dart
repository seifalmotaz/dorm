import 'package:analyzer/dart/element/element.dart';

void parseModels(CompilationUnitElement unitElement) {
  var classes = unitElement.classes.where(
    (element) => element.metadata
        .any((element) => element.element?.displayName == 'Table'),
  );

  for (ClassElement classElement in classes) {
    print('Class: ${classElement.name}');
    print('With fields: ${classElement.fields.map((e) => e.name).join(', ')}');
  }
}

StringBuffer parseClass(ClassElement ce) {
  final StringBuffer buf = StringBuffer();

  return buf;
}