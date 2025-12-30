//
//  ViewExtension.swift
//  LFPopKit
//
//  Created by Calogero Friscia on 30/12/25.
//
import SwiftUI

public extension View {
    
    func injectionViewModel<ViewModel:ObservableObject>(_ vm:ViewModel) -> some View {
    
        modifier(PQPopContentModifier(vm: vm))

    }
}
