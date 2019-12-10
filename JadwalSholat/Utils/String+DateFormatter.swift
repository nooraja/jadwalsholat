//
//  String+DateFormatter.swift
//  JadwalSholat
//
//  Created by NOOR on 02/12/19.
//  Copyright © 2019 NOOR. All rights reserved.
//

import Foundation

extension String {
    
    func toFormatterDate(from originalFormatter: String, to finalFormatter: String) -> String {
        
        let mutableDate: DateFormatter = DateFormatter()
        mutableDate.dateFormat = originalFormatter
        
        let specificDate: Date? = mutableDate.date(from: self)
        mutableDate.dateFormat = finalFormatter
        let resultFormatterDate = mutableDate.string(from: specificDate ?? Date())
        
        return resultFormatterDate
    }
}
