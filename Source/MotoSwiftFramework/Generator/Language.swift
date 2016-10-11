import Foundation

enum Language {
   case Swift
   case ObjC

   func type(for type: AttributeType, scalar: Bool) throws -> String {
      switch (self, type, scalar) {
      case (_, .Binary, _):
         return "NSData"
      case (.Swift, .Boolean, true):
         return "Bool"
      case (.ObjC, .Boolean, true):
         return "BOOL"
      case (_, .Date, _):
         return "NSDate"
      case (_, .Decimal, _):
         return "NSDecimalNumber"
      case (.Swift, .Double, true):
         return "Double"
      case (.ObjC, .Double, true):
         return "double"
      case (.Swift, .Float, true):
         return "Float"
      case (.ObjC, .Float, true):
         return "float"
      case (.Swift, .Integer16, true):
         return "Int16"
      case (.ObjC, .Integer16, true):
         return "int16_t"
      case (.Swift, .Integer32, true):
         return "Int32"
      case (.ObjC, .Integer32, true):
         return "int32_t"
      case (.Swift, .Integer64, true):
         return "Int64"
      case (.ObjC, .Integer64, true):
         return "int64_t"
      case (.Swift, .String, _):
         return "String"
      case (.ObjC, .String, _):
         return "NSString"
      case (_, .Transformable, _):
         return "NSObject"
      case (_, .Boolean, false),
           (_, .Double, false),
           (_, .Float, false),
           (_, .Integer16, false),
           (_, .Integer32, false),
           (_, .Integer64, false):
         return "NSNumber"
      }
   }
}
