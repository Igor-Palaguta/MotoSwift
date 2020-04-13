import ArgumentParser
import Foundation

struct VersionCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "version",
        abstract: "Prints current version"
    )

    private let value = "0.6.0"

    func run() {
        print(value)
    }
}
