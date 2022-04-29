//
//  DropFileView.swift
//  Grades
//
//  Created by Miller on 3/1/22.
//

import SwiftUI

struct DropFileView: View {
    
    @Binding var url: URL?
    @State var isHoveredOver = false
    
    var body: some View {
        let dropDelegate = CSVURLDropDelegate(url: $url, isHoveredOver: $isHoveredOver)

        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.gray, lineWidth: 2)
            Text(fileName())
        }.onDrop(of: [.url], delegate: dropDelegate)
    }
    
    func fileName() -> String {
        if let unwrappedURL = url {
            let fileName = unwrappedURL.lastPathComponent
            return fileName
        } else {
            return "Drop File"
        }
    }
}

// MARK: - Drop Delegate
struct CSVURLDropDelegate: DropDelegate {
    @Binding var url: URL?
    @Binding var isHoveredOver: Bool
    
    func validateDrop(info: DropInfo) -> Bool {
        return info.hasItemsConforming(to: [.fileURL])
    }
    
    func performDrop(info: DropInfo) -> Bool {
        Task {
            let localURL = await urlFrom(info)
            url = localURL
        }
        return true
    }
    
    func dropEntered(info: DropInfo) {
        if info.hasItemsConforming(to: [.fileURL]) {
            isHoveredOver = true
        }
    }
    
    func dropExited(info: DropInfo) {
        isHoveredOver = false
    }
    
    func urlFrom(_ info: DropInfo) async -> URL? {
        guard let item = info.itemProviders(for: [.fileURL]).first else { return nil }
        
        return await withCheckedContinuation { contiuation in
            item.loadItem(forTypeIdentifier: "public.file-url", options: nil) { (urlData, error) in
                if let localURLData = urlData as? Data {
                    let localURL = URL(dataRepresentation: localURLData, relativeTo: nil)
                    if localURL?.pathExtension != "csv" {
                        contiuation.resume(returning: nil)
                    } else {
                        contiuation.resume(returning: localURL)
                    }
                } else {contiuation.resume(returning: nil)}
            }
        }
    }
}
