//
//  CalDropFileView.swift
//  SpectraToConc
//
//  Created by Collin Miller on 4/25/22.
//

import SwiftUI

struct CalDropFileView: View {
    @Binding var calurl: URL?
    @State var isHoveredOver = false
    
    var body: some View {
        let dropDelegate = CSVURLDropDelegate(url: $calurl, isHoveredOver: $isHoveredOver)

        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.gray, lineWidth: 2)
            Text(fileName())
        }.onDrop(of: [.url], delegate: dropDelegate)
    }
    
    func fileName() -> String {
        if let unwrappedURL = calurl {
            let fileName = unwrappedURL.lastPathComponent
            return fileName
        } else {
            return "Drop Calibration File"
        }
    }
}


