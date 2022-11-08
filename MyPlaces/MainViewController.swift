//
//  MainViewController.swift
//  MyPlaces
//
//  Created by Карина on 08.11.2022.
//

import UIKit

class MainViewController: UITableViewController {
    
    let cafeNames = [ "Mama Roma", "Tokyo City", "Giros", "Додо Пицца", "Теремок", "Cinnabon"]

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafeNames.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = cafeNames[indexPath.row]
        cell.imageView?.image = UIImage(named: cafeNames[indexPath.row])

            
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

}
