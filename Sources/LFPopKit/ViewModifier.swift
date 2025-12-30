//
//  ViewModifie.swift
//  LFPopKit
//
//  Created by Calogero Friscia on 30/12/25.
//

import SwiftUI
import Combine
/// Type eraser
internal struct EraseContent:Identifiable {
    
    typealias DestinationPopView = AnyView
    typealias ViewModel = AnyObject
    
    let id:String
    
    private let _destinationPopView: (_ vm:ViewModel?) -> DestinationPopView
    let getPresentationDetent: () -> Set<PresentationDetent>
    
    init<C:PQPopContentPro>(content: C) {
        
        self.id = content.id
     
        self._destinationPopView = { vm in
    
            DestinationPopView(content.destinationPopView(vm as? C.ViewModel) )
        }
        self.getPresentationDetent = content.getPresentationDetent
    }
    
    func showDestination(_ vm:ViewModel?) -> some View {
        _destinationPopView(vm)
    }
}

internal struct PQPopContentModifier<ViewModel:ObservableObject>: ViewModifier {

    let vm:ViewModel?
    
    @State var destinationPopView:EraseContent? = nil

    func body(content: Content) -> some View {
      
            content
            .onReceive(PQManager.shared.publisher, perform: { popQueque in
                
                    // la prima pop della coda viene mandata in view
                if let first = popQueque.first {
                    self.destinationPopView = EraseContent(content: first) } else {
                    
                    self.destinationPopView = nil
                }
                
            })
           .sheet(item: $destinationPopView) { view in
               
               view.showDestination(vm)
                    .presentationDetents(view.getPresentationDetent())
            }
        
        }
}
