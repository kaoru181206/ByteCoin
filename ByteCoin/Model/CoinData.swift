//
//  CoinData.swift
//  ByteCoin
//
//  Created by 白髪馨 on 2022/08/09.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    let asset_id_base: String
    let rate: Double
}
