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
        ),

        BibleQuote(
            text: "The Lord is my strength and my shield; my heart trusts in him, and he helps me.",
            reference: "Psalm 28:7",
            testament: "Old",
            category: .faith
        ),

        BibleQuote(
            text: "Let us hold unswervingly to the hope we profess, for he who promised is faithful.",
            reference: "Hebrews 10:23",
            testament: "New",
            category: .hope
        ),

        BibleQuote(
            text: "So do not fear, for I am with you; do not be dismayed, for I am your God.",
            reference: "Isaiah 41:10",
            testament: "Old",
            category: .courage
        ),

        BibleQuote(
            text: "Now faith is confidence in what we hope for and assurance about what we do not see.",
            reference: "Hebrews 11:1",
            testament: "New",
            category: .faith
        ),

        BibleQuote(
            text: "But those who hope in the Lord will renew their strength. They will soar on wings like eagles.",
            reference: "Isaiah 40:31",
            testament: "Old",
            category: .hope
        ),

        BibleQuote(
            text: "For we live by faith, not by sight.",
            reference: "2 Corinthians 5:7",
            testament: "New",
            category: .faith
        ),

        BibleQuote(
            text: "Wait for the Lord; be strong and take heart and wait for the Lord.",
            reference: "Psalm 27:14",
            testament: "Old",
            category: .hope
        ),

        BibleQuote(
            text: "The Lord is on my side; I will not fear. What can man do to me?",
            reference: "Psalm 118:6",
            testament: "Old",
            category: .courage
        ),

        BibleQuote(
            text: "Because you know that the testing of your faith produces perseverance.",
            reference: "James 1:3",
            testament: "New",
            category: .faith
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
