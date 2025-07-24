//
//  Bookmarker.swift
//  EmBook
//
//  Created by Bill Nguyen on 2025-07-22.
//

import Foundation
import SwiftUI

class Bookmarker: ObservableObject {
    @Published var bookmarkedQuotes: [BibleQuote] = []{
        didSet {
            saveBookmarks()
        }
    }

    init() {
        loadBookmarks()
    }

private func saveBookmarks() {
        if let encoded = try? JSONEncoder().encode(bookmarkedQuotes) {
            UserDefaults.standard.set(encoded, forKey: "bookmarkedQuotes")
        }
    }
    
private func loadBookmarks() {
        if let savedData = UserDefaults.standard.data(forKey: "bookmarkedQuotes") {
            if let decoded = try? JSONDecoder().decode([BibleQuote].self, from: savedData) {
                bookmarkedQuotes = decoded
            }
        }
    }
    
func toggleBookmark (quote: BibleQuote) {
        if let index = bookmarkedQuotes.firstIndex(of: quote) {
        bookmarkedQuotes.remove(at: index)
    } else {
        bookmarkedQuotes.append(quote)
    }
}

func likeQuote (quote: BibleQuote) {
    if !bookmarkedQuotes.contains(quote) {
        bookmarkedQuotes.append(quote)
    }
}
    
func isBookmarked(quote: BibleQuote) -> Bool {
        bookmarkedQuotes.contains(quote)
    }


    
}
