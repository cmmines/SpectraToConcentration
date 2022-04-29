//
//  ConcGraphViewRepresentable.swift
//  SpectraToConc
//
//  Created by Collin Miller on 4/26/22.
//

import Foundation
import SwiftUI

struct unkGraphViewRepresentable: NSViewRepresentable {
    typealias NSViewType = UnkGraphView
    
    @ObservedObject var unkgraphController: UnkGraphController
    
    
    func makeNSView(context: Context) -> UnkGraphView {
        
        let graphView = UnkGraphView(unkgraphController)
        
        graphView.autoresizingMask = [.width, .height]
        
        return graphView
    }
    
    func updateNSView(_ nsView: UnkGraphView, context: Context) {
        
    }
}

