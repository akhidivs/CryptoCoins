//
//  HepticManager.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 05/02/25.
//

import Foundation
import SwiftUI

class HepticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}
