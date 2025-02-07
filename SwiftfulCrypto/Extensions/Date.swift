//
//  Date.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 06/02/25.
//

import Foundation

extension Date {
    
    init(stringDate: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: stringDate)
        self.init(timeInterval: 0, since: date ?? Date())
    }
    
    private var shortDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortDateFormatter.string(from: self)
    }
}
