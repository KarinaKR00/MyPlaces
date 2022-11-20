//
//  ModelOfPlaces.swift
//  MyPlaces
//
//  Created by Карина on 09.11.2022.
//

import RealmSwift
import UIKit



class Place: Object {
    @Persisted var name = ""
    @Persisted var location: String?
    @Persisted var type: String?
    @Persisted var imageData: Data?
    
    
  let placesNames = [ "Mama Roma", "Tokyo City", "Giros", "Додо Пицца", "Теремок", "Cinnabon"]

    func getPlaces() {
        
    
        
        for place in placesNames {
            
            let image = UIImage(named: place)
            guard let imageData = image?.pngData() else { return }
            
            let newPlace = Place()
            newPlace.name = place
            newPlace.location = "Cпб"
            newPlace.type = "Cafe"
            newPlace.imageData = imageData
            
            StorageManager.saveObject(newPlace)
            
           
            
        }
}


}


