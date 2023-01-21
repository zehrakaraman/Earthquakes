//
//  Quake+Color.swift
//  Earthquakes
//
//  Created by Zehra on 12.01.2023.
//

import UIKit

extension Quake {
    var color: UIColor {
        switch magnitude {
        case 0..<1:
            return .green
        case 1..<2:
            return .yellow
        case 2..<3:
            return .orange
        case 3..<5:
            return .red
        case 5..<Double.greatestFiniteMagnitude:
            return UIColor(named: "MagnitudeColor")!
        default:
            return .gray
        }
    }
}
