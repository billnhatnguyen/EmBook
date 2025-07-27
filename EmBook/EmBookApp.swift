//
//  EmBookApp.swift
//  EmBook
//
//  Created by Bill Nguyen on 2025-07-10.
//

import Foundation
import SwiftUI

// The Data Model
struct BibleQuote: Identifiable, Codable, Equatable {
    let id = UUID()
    let text: String
    let reference: String
    let testament: String
    let category: Category
    
    var formattedReference: String {
        "\(reference) (NABRE)"
    }
    
}


enum Category: String, CaseIterable, Codable {
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
        BibleQuote(
            text: "Be strong and courageous. Do not be afraid; do not be discouraged, for the Lord your God will be with you wherever you go.",
            reference: "Joshua 1:9",
            testament: "Old",
            category: .courage
        )
    ]
    
    static func sampleData(for category: Category) -> [BibleQuote] {
        return category == .all ? basicQuotes : basicQuotes.filter { $0.category == category }
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

