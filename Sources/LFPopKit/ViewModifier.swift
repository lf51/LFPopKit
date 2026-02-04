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
   // typealias ViewModel = AnyObject
    
    let id:String
    
    private let _destinationPopView: () -> DestinationPopView
    let getPresentationDetent: () -> Set<PresentationDetent>
    
    init<C:PQPopContentPro>(content: C) {
        
        self.id = content.id
     
        self._destinationPopView = { //vm in
    
            DestinationPopView(content.destinationPopView() )
        }
        self.getPresentationDetent = content.getPresentationDetent
    }
    
    func showDestination() -> some View {
        _destinationPopView()
    }
}

internal struct PQPopContentModifier<ViewModel:ObservableObject>: ViewModifier {

    let vm:ViewModel
    
    @State var destinationPopView:EraseContent? = nil

    func body(content: Content) -> some View {
      
            content
            .onReceive(PQManager.shared.publisher, perform: { popQueque in
                
                    // la prima pop della coda viene mandata in view
                if let first = popQueque.first {
                    self.destinationPopView = EraseContent(content: first)
                } else {
                    
                    self.destinationPopView = nil
                }
                
            })
           .sheet(item: $destinationPopView) { view in
               
               view.showDestination()
                   .environmentObject(vm)
                   .presentationDetents(view.getPresentationDetent())
                  
              /* if let vm {
                   
                       
                       
               } else {
                   view.showDestination()
                       .presentationDetents(view.getPresentationDetent())
               }*/
            }
        }
}
