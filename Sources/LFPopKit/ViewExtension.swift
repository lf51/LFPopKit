//
//  ViewExtension.swift
//  LFPopKit
//
//  Created by Calogero Friscia on 30/12/25.
//
import SwiftUI

public extension View {
    
    func pqAttachPopView() -> some View {
        
        modifier(PQPopContentModifier())

    }
}
