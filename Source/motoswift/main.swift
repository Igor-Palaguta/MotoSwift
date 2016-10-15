import Foundation
import Commander

private let MotoSwiftVersion = "0.0.1"

let main = Group {
   $0.addCommand("entity", "Applies entity template and renders every entity to separate file", entityCommand())
   $0.addCommand("model", "Applies model template and prints code to output", modelCommand())
   $0.addCommand("version", nil, command { print(MotoSwiftVersion) })
}

main.run()
