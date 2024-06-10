//
//  Date.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import Foundation

extension Date {
    
    static var currentTimeStampInString: String {
        return String(describing: NSNumber(value: round(Date().timeIntervalSince1970 * 1000)))
    }
    
}
