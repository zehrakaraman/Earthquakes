//
//  QuakeListViewController+SelectMode.swift
//  Earthquakes
//
//  Created by Zehra on 15.01.2023.
//

import UIKit

extension QuakeListViewController {
    enum SelectMode {
        case active, inactive
        
        var isActive: Bool {
            self == .active
        }
        
        mutating func toggle() {
            switch self {
            case .active:
                self = .inactive
            case .inactive:
                self = .active
            }
        }
    }
}
