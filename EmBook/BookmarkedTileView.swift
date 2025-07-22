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
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(bookmarker.bookmarkedQuotes, id: \.reference) { quote in NavigationLink(destination:insideBookmarked(quote:quote)){
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
            .padding()
        }
        .navigationTitle("Bookmarked Quotes")
    }
}
