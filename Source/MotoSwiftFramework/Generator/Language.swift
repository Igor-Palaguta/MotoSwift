import Foundation

enum Language {
   case Swift
   case ObjC

   func scalarType(for type: AttributeType) -> String? {
      switch (self, type) {
      case (.Swift, .Boolean):
         return "Bool"
      case (.ObjC, .Boolean):
         return "BOOL"
      case (.Swift, .Double):
         return "Double"
      case (.ObjC, .Double):
         return "double"
      case (.Swift, .Float):
         return "Float"
      case (.ObjC, .Float):
         return "float"
      case (.Swift, .Integer16):
         return "Int16"
      case (.ObjC, .Integer16):
         return "int16_t"
      case (.Swift, .Integer32):
         return "Int32"
      case (.ObjC, .Integer32):
         return "int32_t"
      case (.Swift, .Integer64):
         return "Int64"
      case (.ObjC, .Integer64):
         return "int64_t"
      case (_, .Binary),
           (_, .Date),
           (_, .Decimal),
           (_, .String),
           (_, .Transformable):
         return nil
      }
   }

   func type(for type: AttributeType) -> String {
      switch (self, type) {
      case (_, .Binary):
         return "NSData"
      case (_, .Date):
         return "NSDate"
      case (_, .Decimal):
         return "NSDecimalNumber"
      case (.Swift, .String):
         return "String"
      case (.ObjC, .String):
         return "NSString"
      case (_, .Transformable):
         return "NSObject"
      case (_, .Boolean),
           (_, .Double),
           (_, .Float),
           (_, .Integer16),
           (_, .Integer32),
           (_, .Integer64):
         return "NSNumber"
      }
   }
}
