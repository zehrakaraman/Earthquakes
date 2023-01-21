//
//  Quake.swift
//  Earthquakes
//
//  Created by Zehra on 12.01.2023.
//

import Foundation

struct Quake: Identifiable {
    var id: String = UUID().uuidString
    let magnitude: Double
    let place: String
    let time: Date
    let code: String
    let detail: URL
}

extension Array where Element == Quake {
    func indexOfQuake(with id: Quake.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else {
            fatalError()
        }
        return index
    }
}

extension Quake: Decodable {
    private enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
        case place
        case time
        case code
        case detail
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let magnitude = try? values.decode(Double.self, forKey: .magnitude)
        let place = try? values.decode(String.self, forKey: .place)
        let time = try? values.decode(Date.self, forKey: .time)
        let code = try? values.decode(String.self, forKey: .code)
        let detail = try? values.decode(URL.self, forKey: .detail)
        
        guard let magnitude = magnitude,
              let place = place,
              let time = time,
              let code = code,
              let detail = detail
        else {
            throw QuakeError.missingData
        }
        
        self.magnitude = magnitude
        self.place = place
        self.time = time
        self.code = code
        self.detail = detail
    }
    
}

#if DEBUG
extension Quake {
    static var sampleData: [Quake] = [
        Quake(magnitude: 0.8, place: "Shakey Acres", time: Date(timeIntervalSinceNow: -1000), code: "nc73649170", detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!),
        Quake(magnitude: 2.2, place: "Rumble Alley", time: Date(timeIntervalSinceNow: -5000), code: "hv72783692", detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/hv72783692")!)
    ]
}
#endif
