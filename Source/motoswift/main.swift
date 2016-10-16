import Foundation
import Commander

private final class Application {
   let version = "0.0.1"

   func run() {
      let main = Group {
         $0.addCommand("entity",
                       "Applies entity template and renders every entity to separate file",
                       entityCommand())
         $0.addCommand("model",
                       "Applies model template and prints code to output",
                       modelCommand())
         $0.addCommand("version",
                       "Display the current version of MotoSwift",
                       command { print(self.version) })
      }

      main.run()
   }
}

fileprivate let application = Application()
application.run()
