import ArgumentParser
import Foundation

struct MotoSwift: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Generates Swift NSManagedObject subclasses.",
        subcommands: [
            VersionCommand.self,
            ModelCommand.self,
            EntityCommand<HumanFile>.self,
            EntityCommand<MachineFile>.self,
        ]
    )
}

MotoSwift.main()
