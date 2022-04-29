//
//  InitialLayoutView.swift
//  SpectraToConc
//
//  Created by Miller on 4/5/22.
//

import SwiftUI




enum ABSFile: String, CaseIterable, Identifiable {
    case  ExExperimentalAbs1, ExExperimentalAbs2
    var id: Self { self }
}
enum CalFile: String, CaseIterable, Identifiable {
    case  ExCalibrationFile1, ExCalibrationFile2
    var id: Self { self }
}



struct InitialLayoutView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var whatfile: ABSFile = .ExExperimentalAbs1
    @State private var whatcalfile: CalFile = .ExCalibrationFile1
    var body: some View {
        
        
        VStack{
            DropFileView(url: $viewModel.url).frame(minWidth:400, maxWidth: .infinity, minHeight: 20, maxHeight: 50)
            CalDropFileView(calurl: $viewModel.calurl).frame(minWidth:400, maxWidth: .infinity, minHeight: 20, maxHeight: 50)
        }
            List() {
                HStack{
                    Text("Files:")
                }
                Text("ExCalibrationFile1")
                Text("ExExperimentalAbs1")
            }.frame(minWidth:400, maxWidth: .infinity, minHeight: 80, maxHeight: 80)
                
            HStack {
                
                Picker("The Concentration of", selection: $whatfile) {
                    ForEach(ABSFile.allCases) { absfile in
                        Text(absfile.rawValue.capitalized)
                    }
                }
                
                
                Picker("Based On", selection: $whatcalfile) {
                    ForEach(CalFile.allCases) { calfile in
                        Text(calfile.rawValue.capitalized)
                    }
                }
                Text("is: ANSWER")
            }
       
        HSplitView {
            
        VSplitView {
            VStack{
                Text("What Table Picker").padding()
            Text("Display Calibration Table OR Display Spectra Table").frame(minWidth:400, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
            }
            VStack{
                Text("What Graph Picker").padding()
            Text("Graph: Absorbance OR Concentration Line")
                GraphViewRepresentable(graphController: viewModel.graphController)
                    .frame(minWidth: 200, maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
                concGraphViewRepresentable(concgraphController: viewModel.concGraphController)
                    .frame(minWidth: 200, maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
                
            }
        }
            VSplitView {
                Text("General Options").frame(minWidth: 150, maxWidth: .infinity, minHeight: 20, maxHeight: .infinity)
                VStack{
                Text("Graph Options")
                    Text("What Absorbance Picker ie Max, FWHM").frame(minWidth: 150, maxWidth: .infinity, minHeight: 20, maxHeight: .infinity)
                    unkGraphViewRepresentable(unkgraphController: viewModel.unkGraphController)
                                        .frame(minWidth: 200, maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
                }
            }
            
        }
        
        
            
    }
}







//struct InitialLayoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        InitialLayoutView()
//    }
//}
