//
//  Reflections.swift
//  EmBook
//
//  Created by Bill Nguyen on 2025-07-24.
//

import Foundation
import Combine

class Reflections: ObservableObject{
    @Published var notes: [String: String] = [:]
           
    
    init(){
        loadNotes()
    }
    
    
    func saveNotes(){
        if let encoded = try? JSONEncoder().encode(notes){
            UserDefaults.standard.set(encoded, forKey:"quoteRef")
        }
    }
        
    func loadNotes(){
        if let data = UserDefaults.standard.data(forKey:"quoteRef"){
            if let decoded = try? JSONDecoder().decode([String: String].self, from: data){
                notes = decoded
            }
        }
    }
    
    func note(for quote: BibleQuote) -> String {
        notes[quote.reference] ?? ""
    }
    
    func update(note: String, for quote: BibleQuote) {
        notes[quote.reference] = note
        saveNotes()
    }
}
