import Foundation
import Commander

private final class Application {
   let version = "0.1.0"

   func run() {
      let main = Group {
         $0.addCommand("model", "generate code for your model", modelCommand)
         $0.addCommand("human", "generate human code for your model. Does not write to file, if file already exists", humanCommand)
         $0.addCommand("machine", "generate machine code for your model. Overwrites file every time", machineCommand)
         $0.addCommand("version",
                       "current version of MotoSwift",
                       command { print(self.version) })
      }

      main.run()
   }
}

fileprivate let application = Application()
application.run()
