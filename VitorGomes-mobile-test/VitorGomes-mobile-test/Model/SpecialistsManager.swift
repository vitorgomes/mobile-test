//
//  SpecialistsManager.swift
//  VitorGomes-mobile-test
//
//  Created by Vitor Gomes on 06/05/21.
//

import Foundation

enum SpecialistsError {
    
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class SpecialistsManager {
    
    func specialistsRequest(with choosenURL: String, onComplete: @escaping ([SpecialistsData]) -> Void, onError: @escaping (SpecialistsError) -> Void) {
        
        guard let url = URL(string: choosenURL) else {
            
            onError(.url)
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if error == nil {
                
                guard let response = response as? HTTPURLResponse else {
                    
                    onError(.noResponse)
                    return
                }
                
                if response.statusCode == 200 {
                    
                    let decoder = JSONDecoder()
                    
                    if let safeData = data {
                        
                        do {
                            
                            let results = try decoder.decode([SpecialistsData].self, from: safeData)
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
