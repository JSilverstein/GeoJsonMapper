import Foundation

public struct GeoDataModel: Codable {
    public init() {}
    public var type: String?
    public var features: [GeoDataFeature]?
}

public struct GeoDataFeature: Codable {
    public init() {}
    public var type: String?
    public var properties: GeoDataProperties?
    public var geometry: GeoDataGeometry?
}

public struct GeoDataProperties: Codable {
    public init() {}
    public var name: String?
    public var featureclass: String?
    
    //Define custom property values here; name and featureclass are required.
    public var scalerank: Int?
}

public struct GeoDataGeometry: Codable {
    public init() {}
    public var type: String?
    public var coordinates: [Double]?
}
