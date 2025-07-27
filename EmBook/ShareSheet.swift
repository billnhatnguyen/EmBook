//
//  ShareSheet.swift
//  EmBook
//
//  Created by Bill Nguyen on 2025-07-26.
//
import SwiftUI
import Foundation


struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
