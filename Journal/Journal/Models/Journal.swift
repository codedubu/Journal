//
//  Journal.swift
//  Journal
//
//  Created by River McCaine on 1/12/21.
//

import Foundation

class Journal: Codable {
    
    let title: String
    var entries: [Entry]
    
    init(title: String, entries: [Entry] = []) {
        self.title = title
        self.entries = entries
    }
} // End of Class

extension Journal:Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        lhs.title == rhs.title && lhs.entries == rhs.entries
    }
} // End of Extension
