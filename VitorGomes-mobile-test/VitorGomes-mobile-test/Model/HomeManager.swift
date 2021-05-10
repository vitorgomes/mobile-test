//
//  HomeManager.swift
//  VitorGomes-mobile-test
//
//  Created by Vitor Gomes on 06/05/21.
//

import Foundation

enum HomeError {
    
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class HomeManager {
    
    func homeRequest(onComplete: @escaping ([HomeData]) -> Void, onError: @escaping (HomeError) -> Void) {
        
        let urlString = "https://raw.githubusercontent.com/PortalTelemedicina/mobile-test/main/api/home_specialists.json"
        guard let url = URL(string: urlString) else {
            
            onError(.url)
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { ( data, response, error) in

            if error == nil {
                
                guard let response = response as? HTTPURLResponse else {
                    
                    onError(.noResponse)
                    return
                }
                
                if response.statusCode == 200 {
                    
                    let decoder = JSONDecoder()
                    
                    if let safeData = data {
                        
                        do {
                            
                            let results = try decoder.decode([HomeData].self, from: safeData)
                            
                            onComplete(results)
                        } catch {
                            
                            print(error.localizedDescription)
                            onError(.invalidJSON)
                        }
                    }
                } else {
                    
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else {
                
                onError(.taskError(error: error!))
            }
        }
        
        task.resume()
    }
}
