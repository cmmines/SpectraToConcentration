//
//  SpectraToConcApp.swift
//  SpectraToConc
//
//  Created by Miller on 4/5/22.
//

import SwiftUI

@main
struct SpectraToConcApp: App {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
