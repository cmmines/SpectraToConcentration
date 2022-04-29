//
//  ViewModel.swift
//  SpectraToConc
//
//  Created by Miller on 4/11/22.
//

//import Foundation
//import SwiftUI
//
//class ViewModel: ObservableObject {
//    @Published var graphController = GraphController()
//    @Published var concGraphController = ConcGraphController()
//    var parser = Parser()
//    var unknownSpectra: Parser?
//    var calibrationSpectra: Parser?
//
//    @Published var url: URL? {
//        didSet {
//            parser.parseFile(filename: url)
//            unknownSpectra = parser
//            updateSpectraData(with: unknownSpectra ?? parser)
//        }
//    }
//
//    @Published var calurl: URL? {
//        didSet {
//            parser.parseFile(filename: calurl)
//            calibrationSpectra = parser
//            updateCalibrationSpectra(with: unknownSpectra ?? parser)
//        }
//    }
//
//    func updateSpectraData(with parser: Parser) {
//
//
//
//    }
//
//
//    func updateCalibrationSpectra(with spectra: Parser) {
//        concGraphController.concUpdateSpectra(x: spectra.headerRow.map{Double($0) ?? -100}, y: spectra.absorbance.map{$0.max() ?? -100})
////        graphController.concupdateSpectra(x: spectra.headerRow.map{Double($0) y: spectra.absorbance.map{$0.max() ?? -100})
//    }
//
//
//    func getString(fromFile urlIn: URL?) -> String?{
//
//    guard let filePath = urlIn?.path else{ return nil }
//
//    guard let contentData = FileManager.default.contents(atPath: filePath) else { return nil}
//
//        return String(data: contentData, encoding: . utf8)
//
//    }
//}


////
////  ViewModel.swift
////  SpectraToConc
////
////  Created by Miller on 4/11/22.
////
//
import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    //    @Published var spectraDataModel = SpectraDataModel()
    @Published var graphController = GraphController()
    @Published var concGraphController = ConcGraphController()
    @Published var unkGraphController = UnkGraphController()
    
    @Published var url: URL? {
        didSet {
            unkparseURL(url)
        }
    }
    @Published var calurl: URL? {
        didSet {
            parseURL(calurl)
        }
    }
    
    @Published var unkspectraData = UnkSpectraData(unkabsorbanceArray: [], unkwavelengthArray: [])
    @Published var calibrationSpectra = CalibrationSpectra(calabsorbanceArrays: [], calwavelengthArray: [])
    //@Published var wavelengthA: [SpectraData.wavelengthStrings] = []
    
    
    func unkparseURL(_ url: URL?) {
        // Implement parsing logic
        // Update course results data and state
        guard let contentString = getString(fromFile: url) else {
            print("no content in url:\(String(describing: url))")
            return
        }
        
        
        var unkParser = UnkParser()
        
        do {
            
            try unkParser.unkparseFile(filename: url)
            try updateUnkSpectraData(with: unkParser)
            
            
            
        } catch  {
            print(error)
            print("will exit from parseURL for \(String(describing: url))")
            return
        }
        
    }
    
    
    
    func parseURL(_ url: URL?) {
        // Implement parsing logic
        // Update course results data and state
        guard let contentString = getString(fromFile: url) else {
            print("no content in url:\(String(describing: url))")
            return
        }
        
        var parser = Parser()
        
        
        do {
            try parser.parseFile(filename: url)
            //try updateSpectraData(with: parser)
            
            
            try updateCalibrationSpectra(with: parser)
            
            
        } catch  {
            print(error)
            print("will exit from parseURL for \(String(describing: url))")
            return
        }
        
    }
    
    func updateUnkSpectraData(with parser: UnkParser) throws {
        
        //        spectraData.updateSpectraData()
        unkspectraData.updateUnkSpectraData(absorbance: parser.unkabsorbance, wavelength: parser.unkwavelength)
        
        unkGraphController.unkUpdateSpectra(x: unkspectraData.unkwavelengthArray, y: unkspectraData.unkabsorbanceArray)
        
        
    }
    
    
    func updateCalibrationSpectra(with parser: Parser) throws {
        
        //calibrationSpectra = CalibrationSpectra(calabsorbanceArrays: parser.absorbance , calwavelengthArray: parser.wavelength)
        
        calibrationSpectra.updateCalibrationSpectra(absorabance: parser.absorbance, wavelength: parser.wavelength, header: parser.headerRow)
        
        
        
        concGraphController.concUpdateSpectra(x: calibrationSpectra.calHeaderArray, y: calibrationSpectra.maxPoints)
        
        graphController.concupdateSpectra(x: calibrationSpectra.calwavelengthArray, y: calibrationSpectra.calabsorbanceArrays)
        
       //calibrationSpectra.calSlope = (concGraphController.concdgController?.fitCommand(0).value(forProperty: "Slope") as? Double? ?? 1.0) ?? 100
    }
    
    
    func getString(fromFile urlIn: URL?) -> String?{
        
        guard let filePath = urlIn?.path else{ return nil }
        
        guard let contentData = FileManager.default.contents(atPath: filePath) else { return nil}
        
        return String(data: contentData, encoding: . utf8)
        
    }
}

