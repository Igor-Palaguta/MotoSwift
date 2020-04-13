import Foundation

public struct FetchedProperty: Equatable {
    public let name: String
    public let entityName: String
    public let predicateString: String
    public let userInfo: [String: String]
}
