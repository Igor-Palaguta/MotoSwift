import ArgumentParser
import Foundation
import PathKit

extension Path: ExpressibleByArgument {
    public init?(argument: String) {
        self.init(argument)
    }
}
