//
//  CoinModel.swift
//  ByteCoin
//
//  Created by 白髪馨 on 2022/08/09.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let base: String
    let rate: Double
    
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
