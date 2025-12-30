//
//  Protocol.swift
//  LFPopKit
//
//  Created by Calogero Friscia on 30/12/25.
//

import SwiftUI

public protocol PQPopContentPro {
    
    associatedtype PopContent: View
    
    var id:String { get }
    
    func destinationPopView() -> PopContent
    func getPresentationDetent() -> Set<PresentationDetent>
}

