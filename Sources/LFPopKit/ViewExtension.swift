//
//  ViewExtension.swift
//  LFPopKit
//
//  Created by Calogero Friscia on 30/12/25.
//
import SwiftUI

public extension View {
    
    func pqAttachPopModifier<ViewModel:ObservableObject>(_ vm:ViewModel) -> some View {
    
    #if targetEnvironment(macCatalyst)
        modifier(PQPopContentModifier(vm: vm))
        #else
        modifier(PQPopContentModifier<ViewModel>(vm: nil))
    #endif

    }
}
