import Commander
import Foundation

private final class Application {
    private let version = "0.5.0"

    func run() {
        let main = Group {
            $0.addCommand("model",
                          "generate code for your model",
                          ModelCommand.command)
            $0.addCommand("human",
                          "generate human code for your model. Does not write to file, if file already exists",
                          EntityCommand.human)
            $0.addCommand("machine",
                          "generate machine code for your model. Overwrites file every time",
                          EntityCommand.machine)
            $0.addCommand("version",
                          "current version of MotoSwift",
                          command { print(self.version) })
        }

        main.run()
    }
}

private let application = Application()

application.run()
