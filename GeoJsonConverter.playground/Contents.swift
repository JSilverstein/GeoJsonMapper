import Cocoa
import PlaygroundSupport

//Change these fields to match the JSON file name in the Resources folder and the custom user defined object.
let fileName = "TowerData"
let objectArray = [CellTower].self

let jsonFile = Bundle.main.path(forResource: "TowerData", ofType: "json")
let data = try! Data(contentsOf: URL(fileURLWithPath: jsonFile!))
let json = try! JSONDecoder().decode(objectArray, from: data)

var geoArray = GeoDataModel()
geoArray.type = "FeatureCollection"
geoArray.features = [GeoDataFeature]()
//Loop through the user defined items and convert them to
for item in json {
    var feature = GeoDataFeature()
    feature.type = "Feature"
    
    //Define more properties in the GeoData properties class
    var properties = GeoDataProperties()
    properties.name = item.radio
    properties.featureclass = "Tower" //Set this value to your desired featureclass
    
    var geometry = GeoDataGeometry()
    geometry.type = "Point"
    geometry.coordinates = [Double(item.lon ?? "") ?? 0, Double(item.lat ?? "") ?? 0]
    feature.geometry = geometry
    feature.properties = properties
    geoArray.features?.append(feature)
}

let jsonEncoder = JSONEncoder()
let jsonData = try! jsonEncoder.encode(geoArray)
let jsonString = String(data: jsonData, encoding: .utf8)

//In your `Shared Playground Data` folder, add a file names 'locations.json' to receive the data String.
let url = playgroundSharedDataDirectory.appendingPathComponent("locations.json")
print(playgroundSharedDataDirectory.absoluteURL)

do {
    try jsonString!.write(to: url, atomically: true, encoding: .utf8)
} catch {
    print("error")
}

let proof = try? String(contentsOf: url)
