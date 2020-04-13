import Commander
import Foundation
import PathKit

extension Path: ArgumentConvertible {
    public init(parser: ArgumentParser) throws {
        if let value = parser.shift() {
            self.init(value)
        } else {
            throw ArgumentError.missingValue(argument: nil)
        }
    }
}
