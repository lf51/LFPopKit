//
//  ViewModifie.swift
//  LFPopKit
//
//  Created by Calogero Friscia on 30/12/25.
//

import SwiftUI
/// Type eraser
internal struct EraseContent:Identifiable {
    
    typealias DestinationPopView = AnyView
    
    let id:String
    
    private let _destinationPopView: () -> DestinationPopView
    let getPresentationDetent: () -> Set<PresentationDetent>
    
    init<C:PQPopContentPro>(content: C) {
        
        self.id = content.id
        self._destinationPopView = { DestinationPopView(content.destinationPopView()) }
        self.getPresentationDetent = content.getPresentationDetent
    }
    
    func showDestination() -> some View {
        _destinationPopView()
    }
}

internal struct PQPopContentModifier: ViewModifier {

    @State var destinationPopView:EraseContent? = nil

    func body(content: Content) -> some View {
      
            content
            .onReceive(PQManager.shared.publisher, perform: { popQueque in
                
                    // la prima pop della coda viene mandata in view
                if let first = popQueque.first { self.destinationPopView = EraseContent(content: first) } else {
                    self.destinationPopView = nil
                }
                
            })
           .sheet(item: $destinationPopView) { view in
               view.showDestination()
                    .presentationDetents(view.getPresentationDetent())
            }
        
        }
}
