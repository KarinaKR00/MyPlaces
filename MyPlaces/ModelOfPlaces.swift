//
//  ModelOfPlaces.swift
//  MyPlaces
//
//  Created by Карина on 09.11.2022.
//

import UIKit


struct Place {
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var restorantImage: [String]
    
    static let placesNames = [ "Mama Roma", "Tokyo City", "Giros", "Додо Пицца", "Теремок", "Cinnabon"]

    static func getPlaces() -> [Place] {
        
        var places = [Place]()
        
        for place in placesNames {
            places.append(Place(name: place, location: "Санкт-Петербург", type: "Ресторан", image: nil, restorantImage: placesNames))
            
        }
        return places
}


}


