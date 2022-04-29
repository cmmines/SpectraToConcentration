//
//  SpectraData.swift
//  SpectraToConc
//
//  Created by Collin Miller on 4/12/22.
//

import Foundation

struct UnkSpectraData {
    
    
    var unkabsorbanceArray: [Double] = []
    
    var unkwavelengthArray: [Double] = []
    
    var unkmaxPoint: Double = 0
    
    mutating func updateUnkSpectraData(absorbance: [Double], wavelength: [Double]) {
        unkabsorbanceArray = absorbance
        unkwavelengthArray = wavelength
        
        unkmaxPoint = unkabsorbanceArray.max() ?? -100
        print("Unk max Point = \(unkmaxPoint)")
 
       
    }
    
}

struct CalibrationSpectra {
    
    //var concGraphController = ConcGraphController()
    
    var calabsorbanceArrays: [[Double]] = []
    
    var calwavelengthArray: [Double] = []
    
    var maxPoints: [Double] = []
    
    var calHeaderArray: [Double] = []
    
   // var calSlope: Any = 0.0
    
    mutating func updateCalibrationSpectra(absorabance: [[Double]], wavelength: [Double], header: [String]) {
        
        calwavelengthArray = wavelength
        calabsorbanceArrays = absorabance
        calHeaderArray = header.map{Double($0) ?? -100}
        //calSlope = concGraphController.concdgController?.fitCommand(0).value(forProperty: "Slope")
        
        calHeaderArray.removeFirst(1)
        
       
        
        maxPoints = calabsorbanceArrays.map{$0.max() ?? -100}
        print("Cal max Points = \(maxPoints)")
        print(calHeaderArray)
        //print(calSlope)
    }
    
 
}





