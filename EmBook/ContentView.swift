//
//  ContentView.swift
//  EmBook
//
//  Created by Bill Nguyen on 2025-07-10.
//

import SwiftUI

struct ContentView: View {
    
    //This will be the bible quote default which is a random quote using our random quote function
    @State private var currentQuote: BibleQuote? = BibleQuote.randomQuote(for: .all)
    //This will be set to all by default when we don't have a selected category
    @State private var selectedCategory: Category = .all
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Menu {
                    ForEach(Category.allCases, id: \.self) { category in
                        Button {
                            selectedCategory = category
                            currentQuote = BibleQuote.randomQuote(for: category)  // Use 'category' here
                        } label: {
                            Text(category.rawValue)
                        }
                    }
                } label: {
                    Image("prayerHands")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                        .clipShape(Circle())
                }
            }
            .padding()
            //When we change the category, please generate a random quote of that category
            .onChange(of: selectedCategory) { newCategory in currentQuote = BibleQuote.randomQuote(for: newCategory)
            }
        }
            
            Spacer()
            
            if let quote = currentQuote{
                Text("“\(quote.text)”")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text(quote.formattedReference)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                Text("No quote found")
                    .foregroundStyle(.gray)
            }
            Spacer()
            
            Button("New Quote"){
                currentQuote = BibleQuote.randomQuote(for: selectedCategory)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            }
        }

    
    

#Preview {
    ContentView()
}
