//
//  MainViewController.swift
//  MyPlaces
//
//  Created by Карина on 08.11.2022.
//

import UIKit

class MainViewController: UITableViewController {
    
  
    
    var cafeName = Place.getPlaces()

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafeName.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let place = cafeName[indexPath.row]
        
        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        
        cell.imageOfPlaces.layer.cornerRadius = cell.imageOfPlaces.frame.size.height / 2
        cell.imageOfPlaces.clipsToBounds = true
        
        if place.image == nil {
            cell.imageOfPlaces.image = UIImage(named: place.restorantImage[indexPath.row])
        } else {
            cell.imageOfPlaces.image = place.image
        }
        
        return cell
        
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
        cafeName.append(newPlaceVC.newPlace!)
        tableView.reloadData()
    }
   
}
