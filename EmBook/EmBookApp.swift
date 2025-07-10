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
    let category: Category
    
    var formattedReference: String {
        "\(reference) (NABRE)"
    }
}

enum Category: String, CaseIterable {
    case all = "All"
    case courage = "Courage"
    case hope = "Hope"
    case faith = "Faith"
}

extension BibleQuote {
    static let basicQuotes: [BibleQuote] = [
        BibleQuote(
            text: "For to me, to live is Christ, and to die is gain.",
            reference: "Philippians 1:21",
            testament: "New",
            category: .courage
        ),
        BibleQuote(
            text: "The Lord will fight for you; you need only to be still.",
            reference: "Exodus 14:14",
            testament: "Old",
            category: .hope
        ),
    ]
    
    static let categories = ["Courage", "Hope", "Faith"]
    
    static func randomQuote(for category: Category) -> BibleQuote? {
        let filtered = basicQuotes.filter { $0.category == category}
        return filtered.randomElement()
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
