//
//  GraphController.swift
//  UsingDataGraphFramework
//
//  Created by Owen Hildreth on 12/21/21.
//

import Foundation
import SwiftUI

class GraphController: ObservableObject {
    @Published var dgController: DGController?
    private let valueString = "value"
   // private var data = DataModel()
    private var calibrationSpectra = CalibrationSpectra()
    
    
    @Published var adjustableValue = 1.0 {
        didSet {
            let parameter = dgController?.parameter(withName: valueString)
            parameter?.setValue(String(adjustableValue))
            //print("newParameter = \(parameter)")
        }
    }
    
    var computedValue: Double {
        get {return adjustableValue*2}
    }
    
    
    init() {
        if dgController == nil {
            dgController = DGController(fileInBundle: "BasicABS")
        }
    }
    
//    func updateData() {
//        data.update()
//        dgController?.dataColumn(at: 1).setDataWith(data.xData)
//        dgController?.dataColumn(at: 2).setDataWith(data.yData)
//    }
    

    
//    func updateSpectra(x: [Double], y:[[Double]]) {
//
//        //Iterate over this ^ if there is data overwrite if there is no data em]ty
//        //empty dgController?.dataColumn(at: 1).emptyTheColumn()
//
//        // empty all columns
//        let absorbanceCount = y.count
//        dgController?.dataColumn(at: 1).setDataWith(x)
//
//        for i in 0...10 {
//            if i < absorbanceCount {
//                dgController?.dataColumn(at: Int32(i+2)).setDataWith(y[i])
//            } else {
//                dgController?.dataColumn(at: Int32(i+2)).emptyTheColumn()
//            }
//        }
//    }
    
    func concupdateSpectra(x: [Double], y:[[Double]]) {
        
        // empty all columns
        for i in 0...11 {
            dgController?.dataColumn(at: Int32(i)).emptyTheColumn()
        }
    
        
      
        dgController?.dataColumn(at: 1).setDataWith(x)

        for (i,nextAbsorbance) in y.enumerated() {
            
            dgController?.dataColumn(at: Int32(i+2)).setDataWith(nextAbsorbance)
        }
    }
}

extension DGDataColumn {
    func setDataWith(_ values: [Double]) {
        self.setDataFrom(values.map( {String($0)} ))
    }
    
}
