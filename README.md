# MotoSwift. Managed Objects to Swift.
Converts Core Data model to Swift.

## Installation
1. Install MotoSwift by downloading MotoSwift.pkg from the [latest GitHub release](https://github.com/Igor-Palaguta/MotoSwift/releases/latest) and running it.

2. From sources.

Clone or download project.

Run `make install`

If you need all components in one folder run `make bundle`. Now you can copy whole ```motoswift``` folder, and run ```motoswift/bin/motoswift``` from any place

## Usage

* **motoswift entity** - Applies entity template and renders every entity to separate file

  Options:
    * --model - Path to CoreData model.
    * --file-mask - File name mask, e.g: "_{{class}}.swift".
    * --template - Path to entity template.
    * --output - Output directory.
    * --rewrite - Rewrite if exists

* **motoswift model** - Applies model template and prints result to output

  Options:
    * --model - Path to CoreData model.
    * --template - Path to model template.
    * --output - Output file path. If missed prints to console
    * --rewrite - Rewrite file if exists.

## Additional documentation
MotoSwift uses [Stencil](https://github.com/kylef/Stencil) as template language

## Examples

1. *XCode* style

Generate class files:

`motoswift entity --model ./Tests/MotoSwiftFrameworkTests/Resources/TypesModel.xcdatamodeld --template ./Templates/class.stencil --output ./SampleOutput/XCode --no-rewrite --file-mask "{{class}}+CoreDataClass.swift"`

Generate properties files:

`motoswift entity --model ./Tests/MotoSwiftFrameworkTests/Resources/TypesModel.xcdatamodeld --template ./Templates/properties.stencil --output ./SampleOutput/XCode --rewrite --file-mask "{{class}}+CoreDataProperties.swift"`

[SampleOutput/XCode](https://github.com/Igor-Palaguta/MotoSwift/tree/master/SampleOutput/XCode)

2. *Mogenerator* style

Generate machine files:

`motoswift entity --model ./Tests/MotoSwiftFrameworkTests/Resources/TypesModel.xcdatamodeld --template ./Templates/machine.stencil --output ./SampleOutput/Machine --rewrite --file-mask "_{{class}}.swift"`

[SampleOutput/Machine](https://github.com/Igor-Palaguta/MotoSwift/tree/master/SampleOutput/Machine)

Generate human files:

`motoswift entity --model ./Tests/MotoSwiftFrameworkTests/Resources/TypesModel.xcdatamodeld --template ./Templates/human.stencil --output ./SampleOutput/Human --no-rewrite --file-mask "{{class}}.swift"`

[SampleOutput/Human](https://github.com/Igor-Palaguta/MotoSwift/tree/master/SampleOutput/Human)


