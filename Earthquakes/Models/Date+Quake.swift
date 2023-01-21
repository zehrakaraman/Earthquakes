//
//  Date+Quake.swift
//  Earthquakes
//
//  Created by Zehra on 14.01.2023.
//

import Foundation

extension Date {
    var dayAndTimeText: String {
        let timeText = formatted(RelativeFormatStyle.relative(presentation: .named))
        return timeText
    }
}
