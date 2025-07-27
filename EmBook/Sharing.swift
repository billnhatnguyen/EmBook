//
//  Sharing.swift
//  EmBook
//
//  Created by Bill Nguyen on 2025-07-26.
//

import Foundation
import SwiftUI

class Sharing: ObservableObject {
    @Published var shareItems: [Any] = []
    @Published var showShareSheet: Bool = false
    @Published var showShareOptions: Bool = false
    
    var currentQuote: BibleQuote?
    var currentReflection: String?
    
    func shareImageOnly(){
        guard let quote = currentQuote else { return }
        let image = ScreenshotViewv1(quote: quote).screenshot()
        shareItems = [image]
        showShareSheet = true
    }
    
    func shareTextOnly(){
        guard let quote = currentQuote else { return }
        shareItems = [quote.text]
        showShareSheet = true
    }
    
    func shareTextAndReflection() {
        guard let quote = currentQuote else { return }
        let reflectionText = currentReflection ?? ""
        let combinedText = "\(quote.text + "\n - " +  quote.reference)\n\nReflection:\n\(reflectionText)"
        shareItems = [combinedText]
        showShareSheet = true
    }
    
}
