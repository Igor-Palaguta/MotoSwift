import Foundation
import PathKit
import Commander

enum ArgumentError: Error, CustomStringConvertible {
   case missingValue
   case invalidFileNameFormat(actual: String, placeholder: String)

   var description: String {
      switch self {
      case .missingValue:
         return "value for argument not specified"
      case .invalidFileNameFormat(let actual, let placeholder):
         return "\"\(actual)\" - invalid file name mask format. Should contain \"\(placeholder)\""
      }
   }
}

extension Path: ArgumentConvertible {
   public init(parser: ArgumentParser) throws {
      guard let path = parser.shift() else {
         throw ArgumentError.missingValue
      }
      self = Path(path)
   }
}
