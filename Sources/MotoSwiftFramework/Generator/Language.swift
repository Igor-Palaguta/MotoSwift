import Foundation

enum Language {
   case swift
   case objc

   func scalarType(for type: AttributeType) -> String? {
      switch (self, type) {
      case (.swift, .boolean):
         return "Bool"
      case (.objc, .boolean):
         return "BOOL"
      case (.swift, .double):
         return "Double"
      case (.objc, .double):
         return "double"
      case (.swift, .float):
         return "Float"
      case (.objc, .float):
         return "float"
      case (.swift, .integer16):
         return "Int16"
      case (.objc, .integer16):
         return "int16_t"
      case (.swift, .integer32):
         return "Int32"
      case (.objc, .integer32):
         return "int32_t"
      case (.swift, .integer64):
         return "Int64"
      case (.objc, .integer64):
         return "int64_t"
      case (_, .binary),
           (_, .date),
           (_, .decimal),
           (_, .string),
           (_, .transformable):
         return nil
      }
   }

   func objectType(for type: AttributeType) -> String {
      switch (self, type) {
      case (_, .binary):
         return "NSData"
      case (_, .date):
         return "NSDate"
      case (_, .decimal):
         return "NSDecimalNumber"
      case (.swift, .string):
         return "String"
      case (.objc, .string):
         return "NSString"
      case (_, .transformable):
         return "NSObject"
      case (_, .boolean),
           (_, .double),
           (_, .float),
           (_, .integer16),
           (_, .integer32),
           (_, .integer64):
         return "NSNumber"
      }
   }
}
