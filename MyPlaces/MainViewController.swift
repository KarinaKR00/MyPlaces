//
//  MainViewController.swift
//  MyPlaces
//
//  Created by Карина on 08.11.2022.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBOutlet var reversedSortingButton: UIBarButtonItem!
    var cafeName: Results<Place>!
    var ascendingSorting = true

    override func viewDidLoad() {
        super.viewDidLoad()
        cafeName = realm.objects(Place.self)


    }

    // MARK: - Table view data source


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafeName.isEmpty ? 0 : cafeName.count
    }

 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let place = cafeName[indexPath.row]
            StorageManager.deleteObjct(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    


  
  
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let place = cafeName[indexPath.row]
            let newPlaceVC = segue.destination as! NewPlaceTableViewController
            newPlaceVC.currentPlace = place
        }
    }

    
     @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newPlaceVC = segue.source as? NewPlaceTableViewController else { return }
        newPlaceVC.savePlace()
        
        tableView.reloadData()
    }
   
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        
       sorted()
    }
    
    
    @IBAction func reversedSorting(_ sender: Any) {
        
        ascendingSorting.toggle()
        if ascendingSorting {
            reversedSortingButton.image = UIImage(named: "AZ")
        } else {
            reversedSortingButton.image = UIImage(named: "ZA")
        }
        sorted()
    }
    private func sorted() {
        if segmentedControl.selectedSegmentIndex == 0 {
            cafeName = cafeName.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else {
            cafeName = cafeName.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        tableView.reloadData()
    }
}
