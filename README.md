# MotoSwift. Managed Objects to Swift.
Converts Core Data model to Swift subclasses.

#Examples:

Generates machine files:
motoswift entity --model ./Tests/MotoSwiftFrameworkTests/Resources/TypesModel.xcdatamodeld --template ./Templates/machine.stencil --output ./SampleOutput/Machine --rewrite --file-mask "_{{class}}.swift"

Generates human files:
motoswift entity --model ./Tests/MotoSwiftFrameworkTests/Resources/TypesModel.xcdatamodeld --template ./Templates/human.stencil --output ./SampleOutput/Human --no-rewrite --file-mask "{{class}}.swift"
