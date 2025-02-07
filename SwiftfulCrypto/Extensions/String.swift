//
//  String.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 06/02/25.
//

import Foundation

extension String {
    
    var removingHTMLOccurences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
