//
//  MainViewController.swift
//  MyPlaces
//
//  Created by Карина on 08.11.2022.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {
    
    var cafeName: Results<Place>!

    override func viewDidLoad() {
        super.viewDidLoad()
        cafeName = realm.objects(Place.self)


    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafeName.isEmpty ? 0 : cafeName.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let place = cafeName[indexPath.row]
        
        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlaces.image = UIImage(data: place.imageData!)
        
        cell.imageOfPlaces.layer.cornerRadius = cell.imageOfPlaces.frame.size.height / 2
        cell.imageOfPlaces.clipsToBounds = true
        
       
        return cell
        
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let place = cafeName[indexPath.row]
            StorageManager.deleteObjct(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    


  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
     @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newPlaceVC = segue.source as? NewPlaceTableViewController else { return }
        newPlaceVC.savePlace()
        
        tableView.reloadData()
    }
   
}
