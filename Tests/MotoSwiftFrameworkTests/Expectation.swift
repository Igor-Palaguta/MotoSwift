import Foundation
import Spectre

extension ExpectationType where ValueType: Collection, ValueType.Iterator.Element: Equatable, ValueType.IndexDistance == Int {
   public func containsSameElements(with other: [ValueType.Iterator.Element]) throws {
      let value = try expression()

      if let value = value, value.count == other.count && !value.contains { !other.contains($0) } {
         //passed
      } else {
         throw failure("\(value) does not containsSameElements with \(other)")
      }
   }
}

extension ExpectationType where ValueType: FloatingPoint {
   public func beClose(to expectedValue: ValueType, within delta: ValueType = ValueType.defaultDelta) throws {
      let value = try expression()

      if let value = value, abs(value - expectedValue) < delta {
         //passed
      } else {
         throw failure("\(value) is not beClose \(expectedValue)")
      }
   }
}

private extension FloatingPoint {
   static var defaultDelta: Self {
      return Self(sign: .plus, exponent: -10, significand: 1)// ~0.001
   }
}
