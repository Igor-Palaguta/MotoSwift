import Foundation

public enum MotoError: Error, CustomStringConvertible {
   case invalidModelType(String)
   case absentPlistKey(key: String, plistPath: String)
   case unknownAttributeType(String)

   public var description: String {
      switch self {
      case .invalidModelType(let modelPath):
         return "Invalid model type: '\(modelPath)'"
      case .absentPlistKey(let key, let plistPath):
         return "'\(key)' absent in \(plistPath)"
      case .unknownAttributeType(let attributeType):
         return "Unexpected attribute type: '\(attributeType)'"
      }
   }
}
