//
//  Result.swift
//  JadwalSholat
//
//  Created by NOOR on 30/11/19.
//  Copyright © 2019 NOOR. All rights reserved.
//

import Foundation

public enum Result<T> {
    
    case success(T, Int?)
    case fail(Error?, Int?)
}
