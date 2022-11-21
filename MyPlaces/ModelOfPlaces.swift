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
    
    convenience init(name: String, location: String?, type: String?, imageData: Data?) {
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
    


}


