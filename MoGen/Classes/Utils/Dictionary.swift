import Foundation

public func += <U, T>( lhs: inout [U:T], rhs: [U:T]) {
   for (key, value) in rhs {
      lhs[key] = value
   }
}

public func + <U, T>(lhs: [U:T], rhs: [U:T]) -> [U:T] {
   var result = lhs
   result += rhs
   return result
}

public func += <U, T>( lhs: inout [U:Any], rhs: [U:T]) {
   for (key, value) in rhs {
      lhs[key] = value
   }
}

public func + <U, T>(lhs: [U:Any], rhs: [U:T]) -> [U:Any] {
   var result = lhs
   result += rhs
   return result
}

public func + <U, T>(lhs: [U:T], rhs: [U:Any]) -> [U:Any] {
   var result = rhs
   result += lhs
   return result
}
