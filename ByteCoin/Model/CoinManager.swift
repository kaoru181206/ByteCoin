//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(coin: CoinModel)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "C2C586E0-182A-4AA3-9CD1-E6E3BD4A168A"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        // 1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let tast = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error)
                    return
                }
                
                if let safeData = data {
                    //Format the data we got back as a string to be able to print it.
                    if let coin = self.parseJSON(safeData) {
                        // ViewControllerへ必要なデータを戻す
                        self.delegate?.didUpdateCoin(coin: coin)
                    }
                }
            }
            
            //4. Start the task
            tast.resume()
                
        }
    }
    
    func parseJSON(_ data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let base = decodedData.asset_id_base
            let rate = decodedData.rate
            let coinModel = CoinModel(base: base, rate: rate)
            return coinModel
        } catch {
            print(error)
            return nil
        }
        
        
        
    
    }

    
}
