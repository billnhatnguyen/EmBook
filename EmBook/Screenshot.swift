//
//  Screenshot.swift
//  EmBook
//
//  Created by Bill Nguyen on 2025-07-26.
//
import SwiftUI
import Foundation

extension View {
    func screenshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        let size = controller.view.intrinsicContentSize
        
        view?.bounds = CGRect(origin: .zero, size: size)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
    }
    
}
