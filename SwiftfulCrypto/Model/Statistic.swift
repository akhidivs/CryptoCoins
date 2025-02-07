//
//  Statistic.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 04/02/25.
//

import Foundation

struct Statistic: Identifiable {
    
    let id = UUID().uuidString
    let name: String
    let value: String
    let percentageChange: Double?
    
    init(name: String, value: String, percentageChange: Double? = nil) {
        self.name = name
        self.value = value
        self.percentageChange = percentageChange
    }
}
