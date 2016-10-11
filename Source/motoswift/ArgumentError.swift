import Foundation

enum ArgumentError: Error, CustomStringConvertible {
   case requiredArgument(String)
   case invalidFileNameFormat(actual: String, placeholder: String)
   var description: String {
      switch self {
      case .requiredArgument(let argument):
         return "--\(argument) argument is not specified"
      case .invalidFileNameFormat(let actual, let placeholder):
         return "\"\(actual)\" - invalid file name mask format. Should contain \"\(placeholder)\""
      }
   }
}

protocol EmptyPossible {
   var isEmpty: Bool { get }
}

extension String: EmptyPossible {
}

func requiredValue<V: EmptyPossible>(ofArgument argument: String, withValue value: V) throws -> V {
   if value.isEmpty {
      throw ArgumentError.requiredArgument(argument)
   }
   return value
}
