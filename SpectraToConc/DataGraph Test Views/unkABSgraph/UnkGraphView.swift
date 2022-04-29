//
//  ConcGraphView.swift
//  SpectraToConc
//
//  Created by Collin Miller on 4/26/22.
//

import Foundation
import SwiftUI

class UnkGraphView: NSView {
    var unkgraphController: UnkGraphController? = nil

    private var graphView: DPDrawingView = DPDrawingView()
    
    convenience init(_ graphControllerIn: UnkGraphController) {
        let newFrame = NSRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100.0, height: 100.0))
        self.init(frame: newFrame)
        
        
        unkgraphController = graphControllerIn
        
        //graph = DPDrawingView()
        
        graphView = DPDrawingView()
        graphView.frame = newFrame
        graphView.autoresizingMask = [.width, .height]
        
        self.addSubview(graphView)
        unkgraphController?.unkdgController?.setDrawingView(graphView)
        
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




