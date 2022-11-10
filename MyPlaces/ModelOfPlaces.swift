//
//  ModelOfPlaces.swift
//  MyPlaces
//
//  Created by Карина on 09.11.2022.
//

import Foundation


struct Place {
    var name: [String]
    var location: String
    var type: String
    var image: [String]
    
    static let placesNames = [ "Mama Roma", "Tokyo City", "Giros", "Додо Пицца", "Теремок", "Cinnabon"]

    static func getPlaces() -> [Place] {
        
        var places = [Place]()
        
        for _ in placesNames {
            places.append(Place(name: placesNames, location: "Санкт-Петербург", type: "Ресторан", image: placesNames))
            
        }
        return places
}


}


