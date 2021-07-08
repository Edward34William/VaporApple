import ConvertSwift
import CoreLocation
import Foundation

public protocol FactoryType {
    var typeSelf: Self.Type {get}
    static var typeSelf: Self.Type {get}
}

public extension FactoryType {
    var typeSelf: Self.Type {
        return Self.self
    }

    static var typeSelf: Self.Type {
        return Self.self
    }
}

public protocol FactoryIdentifier {
    var identifier: String {get}
    static var identifier: String {get}
}

public extension FactoryIdentifier {
    var identifier: String {
        return String(describing: Self.self)
    }

    static var identifier: String {
        return String(describing: Self.self)
    }
}

public protocol ResponseModel {
    static func factoryMethod(keyPath: String?, data: Data?) -> Self?
    static func factoryMethods(keyPath: String?, data: Data?) -> [Self]?
}

public extension ResponseModel where Self: Decodable {
    static func factoryMethod(keyPath: String?, data: Data?) -> Self? {
        data?.toData(keyPath: keyPath).toModel(Self.self)
    }

    static func factoryMethods(keyPath: String?, data: Data?) -> [Self]? {
        data?.toData(keyPath: keyPath).toModel([Self].self)
    }
}

public protocol Prototype {
    func clone() -> Self?
}

public extension Prototype where Self: Codable {
    func clone() -> Self? {
        toData()?.toModel(Self.self)
    }
}

public protocol Builder {}

public extension Builder {
    @discardableResult
    func apply<T>(transform: (inout Self) -> T) -> Self {
        var newSelf = self
        _ = transform(&newSelf)
        return newSelf
    }

    @discardableResult
    func apply(transform: (inout Self) -> Void) -> Self {
        var newSelf = self
        transform(&newSelf)
        return newSelf
    }

    @discardableResult
    func apply(transform: (inout Self) throws -> Void) rethrows -> Self {
        var newSelf = self
        try transform(&newSelf)
        return newSelf
    }
}

//https://bugs.swift.org/browse/SR-6265
//protocol BaseModel: Codable, Hashable, Identifiable, Equatable, ResponseModel, Prototype, Builder, FactoryType, FactoryIdentifier {
protocol BaseModel: Codable, Hashable, Identifiable, ResponseModel, Prototype, Builder, FactoryType, FactoryIdentifier {
    associatedtype IDValue: Codable, Equatable
    var id: IDValue? { get set }
}

struct GeoPoint: BaseModel {
    var id: String?
    let latitude: Double
    let longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension CLLocationCoordinate2D {
    func toLocation() -> CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }

    func toGeoPoint() -> GeoPoint {
        GeoPoint(latitude: latitude, longitude: longitude)
    }
}

extension CLLocation {
    func toLocationCoordinate2D() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }

    func toGeoPoint() -> GeoPoint {
        toLocationCoordinate2D().toGeoPoint()
    }
}

extension GeoPoint {
    func toLocation() -> CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }

    func asLocationCoordinate2D() -> CLLocationCoordinate2D {
        toLocation().toLocationCoordinate2D()
    }
}
