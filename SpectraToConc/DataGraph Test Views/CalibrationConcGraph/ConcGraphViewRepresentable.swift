//
//  ConcGraphViewRepresentable.swift
//  SpectraToConc
//
//  Created by Collin Miller on 4/26/22.
//

import Foundation
import SwiftUI

struct concGraphViewRepresentable: NSViewRepresentable {
    typealias NSViewType = ConcGraphView
    
    @ObservedObject var concgraphController: ConcGraphController
    
    
    func makeNSView(context: Context) -> ConcGraphView {
        
        let graphView = ConcGraphView(concgraphController)
        
        graphView.autoresizingMask = [.width, .height]
        
        return graphView
    }
    
    func updateNSView(_ nsView: ConcGraphView, context: Context) {
        
    }
}

