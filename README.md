# MotoSwift. Managed Objects to Swift.
Converts Core Data model to Swift.

## Installation
Clone or download project.

Run Swift Package Manager build command:
`swift build --configuration release`

Now you can find MotoSwift in `./.build/release/motoswift`

## Usage

* **motoswift entity** - Renders every entity to separate file

  Options:
    * --model - Path to CoreData model.
    * --file-mask - File name mask, e.g: "_{{class}}.swift".
    * --template - Path to entity template.
    * --output - Output directory.
    * --rewrite - Rewrite if exists

* **motoswift model** - Prints rendered model to one output

  Options:
    * --model - Path to CoreData model.
    * --template - Path to model template.

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


