import Foundation
import Spectre

extension ExpectationType where ValueType: Collection, ValueType.Iterator.Element: Equatable {
    func containsSameElements(with other: [ValueType.Iterator.Element]) throws {
        let value = try expression()

        if let value = value, value.count == other.count && value.allSatisfy({ other.contains($0) }) {
            return
        }

        throw failure("\(String(describing: value)) does not containsSameElements with \(other)")
    }
}

extension ExpectationType where ValueType: FloatingPoint {
    func beClose(to expectedValue: ValueType, within delta: ValueType = ValueType.defaultDelta) throws {
        let value = try expression()

        if let value = value, abs(value - expectedValue) < delta {
            return
        }

        throw failure("\(String(describing: value)) is not beClose \(expectedValue)")
    }
}

extension FloatingPoint {
    static var defaultDelta: Self {
        return Self(sign: .plus, exponent: -10, significand: 1) // ~0.001
    }
}
