//
//  QuakeClient.swift
//  Earthquakes
//
//  Created by Zehra on 14.02.2023.
//

import Foundation

class QuakeClient {
    
    var quakes: [Quake] {
        get async throws {
            fatalError("Unimplemented")
//            let data = try await downloader.httpData(from: feedURL)
//            let allQuakes = try decoder.decode(GeoJSON, from: data)
//            return allQuakes.quakes
        }
    }
    
    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .millisecondsSince1970
        return aDecoder
    }()

    private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}

