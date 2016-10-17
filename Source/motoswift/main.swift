import Foundation
import Commander

private final class Application {
   let version = "0.0.1"

   func run() {
      let main = Group {
         $0.addCommand("entity",
                       "Apply entity template and render every entity to separate file",
                       entityCommand())
         $0.addCommand("model",
                       "Apply model template and print code to output or file",
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
