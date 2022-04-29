//
//  Parser.swift
//  SpectraToConc
//
//  Created by Miller on 4/11/22.
//

import Foundation

struct Parser {
    var file: URL? = nil
    var data: String = ""
    
   //var concentration = Double()
    var headerRow: [String] = []
    var wavelength: [Double] = []
    var absorbance: [[Double]] = []
    
    
    mutating func parseFile(filename: URL?) {
        file = filename
        readFile()
        parseContent()
    }
    mutating func readFile() {
        guard let filePath = file?.path else {print("No file at URL"); return}
        guard let contentData = FileManager.default.contents(atPath: filePath) else {print("No data at: \(filePath)"); return}
        guard let content = String(data: contentData, encoding: .utf8) else { print("File is empty"); return }
        data = content
    }
    mutating func parseContent() {
        // empty arrays
        headerRow = []
        wavelength = []
        absorbance = []
        
        // Seperating string into rows
        var rows = data.components(separatedBy: .newlines)
        rows = rows.filter({!$0.isEmpty}) // removing empty rows
        // remove empty rows
        
        // Pulling data from header row and then removing
        headerRow = rows[0].components(separatedBy: ",")
        rows.removeFirst(1)
        
        // using first row to initialize absorbance array size
        var row1values = rows[0].components(separatedBy: ",")
        wavelength.append(Double(row1values[0]) ?? -100)
        row1values.removeFirst(1)
        for value in row1values {
            absorbance.append([Double(value) ?? -100 ])
        }
        rows.removeFirst(1)
        
        // adding the remaining data
        for row in rows {
            var values = row.components(separatedBy: ",")
            wavelength.append(Double(values[0]) ?? -100 )
            values.removeFirst(1)
            for (i,value) in values.enumerated() {
                
                absorbance[i].append(Double(value) ?? -100)
                
            }
        }
    }
}

struct UnkParser {
    var file: URL? = nil
    var data: String = ""


    var unkheaderRow: [String] = []
    var unkwavelength: [Double] = []
    var unkabsorbance: [Double] = []


    mutating func unkparseFile(filename: URL?) {
        file = filename
        unkreadFile()
        unkparseContent()
    }
    mutating func unkreadFile() {
        guard let filePath = file?.path else {print("No file at URL"); return}
        guard let contentData = FileManager.default.contents(atPath: filePath) else {print("No data at: \(filePath)"); return}
        guard let content = String(data: contentData, encoding: .utf8) else { print("File is empty"); return }
        data = content
    }
    mutating func unkparseContent() {
        // empty arrays
        unkheaderRow = []
        unkwavelength = []
        unkabsorbance = []

        // Seperating string into rows
        var rows = data.components(separatedBy: .newlines)
        rows = rows.filter({!$0.isEmpty}) // removing empty rows
        // remove empty rows

        // Pulling data from header row and then removing
        unkheaderRow = rows[0].components(separatedBy: ",")
        rows.removeFirst(1)


        // adding the remaining data
        for row in rows {
            var values = row.components(separatedBy: ",")
            unkwavelength.append(Double(values[0]) ?? -100 )
          
            values.removeFirst(1)
            
            unkabsorbance.append(Double(values[0]) ?? -100 )

               

            }
        }
    }

