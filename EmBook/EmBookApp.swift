//
//  EmBookApp.swift
//  EmBook
//
//  Created by Bill Nguyen on 2025-07-10.
//

import Foundation
import SwiftUI

// The Data Model
struct BibleQuote: Identifiable, Codable {
    let id = UUID()
    let text: String
    let reference: String
    let testament: String
    let category: String
    
    var formattedReference: String {
        "\(reference) (NABRE)"
    }
}

extension BibleQuote {
    static let basicQuotes: [BibleQuote] = [
        BibleQuote(
            text: "For to me, to live is Christ, and to die is gain.",
            reference: "Philippians 1:21",
            testament: "New",
            category: "Courage"
        ),
        BibleQuote(
            text: "The Lord will fight for you; you need only to be still.",
            reference: "Exodus 14:14",
            testament: "Old",
            category: "Hope"
        ),
    ]
    
    static let categories = ["Courage", "Hope", "Faith"]
    
    static func filteredQuotes(by category: String) -> [BibleQuote] {
        if category == "All" {
            return basicQuotes
        }
        return basicQuotes.filter{$0.category == category}
    }
}

@main
struct EmBookApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
