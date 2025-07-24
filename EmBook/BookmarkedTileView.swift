//
//  BookmarkedTileView.swift
//  EmBook
//
//  Created by Bill Nguyen on 2025-07-22.
//

import SwiftUI

public struct BookmarkedTileView: View {
    @ObservedObject var bookmarker = Bookmarker()
    
    let columns = [GridItem(.flexible()),GridItem(.flexible()) ]
    
    private var bookmarkedQuotes: [BibleQuote] {
        var seen = Set<String>()
        return bookmarker.bookmarkedQuotes.filter { quote in
            if seen.contains(quote.reference) {
                return false
            } else {
                seen.insert(quote.reference)
                return true
            }
        }
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(bookmarkedQuotes, id: \.reference) { quote in quoteTile(for: quote)
                }
            }
            .padding()
        }
        .navigationTitle("Bookmarked Quotes")
    }
    
    @ViewBuilder
    private func quoteTile(for quote: BibleQuote) -> some View{
        NavigationLink(destination:InsideBookmarked(bookmarker: bookmarker, quote:quote)){
            VStack(spacing: 8) {
                Text("“\(quote.text)”")
                    .font(.body)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                
                Text(quote.formattedReference)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 120)
            .background(Color.white)
            .cornerRadius(12)
        }
    }
    
}
