//
//  ConcGraphController.swift
//  SpectraToConc
//
//  Created by Collin Miller on 4/26/22.
//

import Foundation
import SwiftUI

class UnkGraphController: ObservableObject {
    @Published var unkdgController: DGController?
    private let valueString = "value"
    //private var data = DataModel()
    private var unkspectraData = UnkSpectraData()
    
    
    @Published var concadjustableValue = 1.0 {
        didSet {
            let parameter = unkdgController?.parameter(withName: valueString)
            parameter?.setValue(String(concadjustableValue))
            //print("newParameter = \(parameter)")
        }
    }
    
    var computedValue: Double {
        get {return concadjustableValue*2}
    }
    
    
    init() {
        if unkdgController == nil {
            unkdgController = DGController(fileInBundle: "UnkABS")
        }
    }
    
//    func updateData() {
//        data.update()
//        unkdgController?.dataColumn(at: 1).setDataWith(data.xData)
//        unkdgController?.dataColumn(at: 2).setDataWith(data.yData)
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
    
    func unkUpdateSpectra(x: [Double], y:[Double]) {
        
        // empty all columns
        for i in 0...2 {
            unkdgController?.dataColumn(at: Int32(i)).emptyTheColumn()
        }
    
        
      
        unkdgController?.dataColumn(at: 1).setDataWith(x)

    
            
        unkdgController?.dataColumn(at: 2).setDataWith(y)
        }
    }



