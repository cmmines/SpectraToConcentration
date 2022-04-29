//
//  ContentView.swift
//  SpectraToConc
//
//  Created by Miller on 4/5/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        InitialLayoutView(viewModel: viewModel).padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
