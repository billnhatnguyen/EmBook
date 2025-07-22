//
//  Bookmarked.swift
//  EmBook
//
//  Created by Bill Nguyen on 2025-07-22.
//

import SwiftUI

struct insideBookmarked: View {
    let quote: BibleQuote
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("“\(quote.text)”")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text(quote.formattedReference)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
        }
        .navigationTitle("\(quote.reference)")
    }
}
