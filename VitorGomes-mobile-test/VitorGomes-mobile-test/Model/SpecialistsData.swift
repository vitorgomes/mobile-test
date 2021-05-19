//
//  SpecialistsData.swift
//  VitorGomes-mobile-test
//
//  Created by Vitor Gomes on 06/05/21.
//

import Foundation

struct SpecialistsData: Codable {
    
    var name: String = ""
    var distance: Double?
    var description: String = ""
    var actions: Actions
}

struct Actions: Codable {
    
    var chat: String = ""
    var call: String?
}
