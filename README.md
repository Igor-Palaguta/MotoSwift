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

* Generates machine files:

`motoswift entity --model ./Tests/MotoSwiftFrameworkTests/Resources/TypesModel.xcdatamodeld --template ./Templates/machine.stencil --output ./SampleOutput/Machine --rewrite --file-mask "_{{class}}.swift"`

* Generates human files:

`motoswift entity --model ./Tests/MotoSwiftFrameworkTests/Resources/TypesModel.xcdatamodeld --template ./Templates/human.stencil --output ./SampleOutput/Human --no-rewrite --file-mask "{{class}}.swift"`

[SampleOutput](https://github.com/Igor-Palaguta/MotoSwift/tree/master/SampleOutput)
