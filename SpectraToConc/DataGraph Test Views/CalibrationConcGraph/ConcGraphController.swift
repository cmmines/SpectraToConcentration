//
//  ConcGraphController.swift
//  SpectraToConc
//
//  Created by Collin Miller on 4/26/22.
//

import Foundation
import SwiftUI

class ConcGraphController: ObservableObject {
    @Published var concdgController: DGController?
    private let valueString = "value"
    //private var data = DataModel()
    private var calibrationSpectra = CalibrationSpectra()
    
    
    @Published var concadjustableValue = 1.0 {
        didSet {
            let parameter = concdgController?.parameter(withName: valueString)
            parameter?.setValue(String(concadjustableValue))
            //print("newParameter = \(parameter)")
        }
    }
    
    var computedValue: Double {
        get {return concadjustableValue*2}
    }
    
    
    init() {
        if concdgController == nil {
            concdgController = DGController(fileInBundle: "MaxABSvsConc")
        }
    }
    
//    func updateData() {
//        data.update()
//        concdgController?.dataColumn(at: 1).setDataWith(data.xData)
//        concdgController?.dataColumn(at: 2).setDataWith(data.yData)
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
    
    func concUpdateSpectra(x: [Double], y:[Double]) {
        
        // empty all columns
        for i in 0...2 {
            concdgController?.dataColumn(at: Int32(i)).emptyTheColumn()
        }
    
        
      
        concdgController?.dataColumn(at: 1).setDataWith(x)

        concdgController?.dataColumn(at: 2).setDataWith(y)
        
        
        
        }
    }



