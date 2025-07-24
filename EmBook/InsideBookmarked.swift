//
//  Bookmarked.swift
//  EmBook
//
//  Created by Bill Nguyen on 2025-07-22.
//

import SwiftUI

struct InsideBookmarked: View {
    @ObservedObject var bookmarker: Bookmarker
    @ObservedObject private var reflection = Reflections()
    
    @State private var reflectionText: String = ""
    @State private var showReflection = false
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
            
            
            if !reflectionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Reflection:")
                        .font(.headline)
                    Text(reflectionText)
                        .font(.body)
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
            } else {
                Text("No reflection yet.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            HStack{
                //Bookmarker
                Button(action: {
                    bookmarker.toggleBookmark(quote: quote)
                }){
                    let isBookmarked = bookmarker.isBookmarked(quote:quote)
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(isBookmarked ? .blue : .gray)
                        .padding()
                }
                
                //Reflector
                Button(action:{
                    withAnimation{
                        showReflection.toggle()
                    }
                }){
                    Image(systemName:"square.and.pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .padding()
                }
                
                
                
                
                .navigationTitle("\(quote.reference)")
            }
            
            if showReflection {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Edit Your Reflection")
                        .font(.headline)

                    TextEditor(text: $reflectionText)
                        .frame(height: 150)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                    Button("Save Reflection") {
                        reflection.update(note: reflectionText, for: quote)
                        showReflection = false
                    }
                    .buttonStyle(.borderedProminent)
                }
                .transition(.opacity)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            reflection.loadNotes()
            reflectionText = reflection.note(for: quote)
        }
    }
}

