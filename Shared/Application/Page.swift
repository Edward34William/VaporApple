import Foundation

public struct Page<T> {

    public let items: [T]

    public let metadata: PageMetadata

    public init(items: [T], metadata: PageMetadata) {
        self.items = items
        self.metadata = metadata
    }

    public func map<U>(_ transform: (T) throws -> (U)) rethrows -> Page<U> where U: Codable {
        try .init(items: self.items.map(transform),metadata: self.metadata)
    }
}

extension Page: Equatable where T: Equatable {
    public static func == (lhs: Page<T>, rhs: Page<T>) -> Bool {
        lhs.items == rhs.items
    }
}

extension Page: Encodable where T: Encodable {}
extension Page: Decodable where T: Decodable {}

public struct PageMetadata: Codable, Equatable {
    
    public let page: Int

    public let per: Int

    public let total: Int
    
    var ableLoading: Bool {
        return page*per < total
    }
}
