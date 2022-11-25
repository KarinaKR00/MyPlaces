//
//  NewPlaceTableViewController.swift
//  MyPlaces
//
//  Created by Карина on 13.11.2022.
//

import UIKit

class NewPlaceTableViewController: UITableViewController {
    
    var currentPlace: Place? 
    var imageIsChanged = false
    
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var placeImage: UIImageView!
    @IBOutlet var placeName: UITextField!
    @IBOutlet var placeLocation: UITextField!
    @IBOutlet var placeType: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
        
        
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let actionSheet = UIAlertController(
                title: nil,
                message: nil,
                preferredStyle: .actionSheet)
            let camera = UIAlertAction(
                title: "Camera",
                style: .default) { _ in
                    self.chooseInagePicker(sourse: .camera)
                }
            
            
            let photo = UIAlertAction(
                title: "Photo",
                style: .default) { _ in
                    self.chooseInagePicker(sourse: .photoLibrary)
                }
            
            
            let cancel = UIAlertAction(
                title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
            
        } else {
            view.endEditing(true)
        }
    }
    func savePlace() {
        
        
        var image: UIImage?
        
        if imageIsChanged {
            image = placeImage.image
        } else {
            image = UIImage(named: "eat")
        }
        
        let imageData = image?.pngData()
        
        let newPlace = Place(name: placeName.text!,
                             location: placeLocation.text,
                             type: placeType.text,
                             imageData: imageData)
        
        if currentPlace != nil {
            try! realm.write {
                currentPlace?.name = newPlace.name
                currentPlace?.location = newPlace.location
                currentPlace?.type = newPlace.type
                currentPlace?.imageData = newPlace.imageData
            }
            } else {
                StorageManager.saveObject(newPlace)
            }
        }
        
       
        
 
    
    private func setupEditScreen() {
        if currentPlace != nil {
            setupNavigationBar()
            imageIsChanged = true
            guard let data = currentPlace?.imageData, let image = UIImage(data: data) else { return }
            placeImage.image = image
            placeImage.contentMode = .scaleAspectFill
            placeName.text = currentPlace?.name
            placeType.text = currentPlace?.type
            placeLocation.text = currentPlace?.location
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(
                title: "",
                style: .plain,
                target: nil,
                action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentPlace?.name
        saveButton.isEnabled = true
    }
        
        
        @IBAction func canselAction(_ sender: Any) {
            dismiss(animated: true)
        }
    }

    
    
    
    // MARK: - Text Field Delegate
    
    
    extension NewPlaceTableViewController: UITextFieldDelegate {
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        @objc private func textFieldChanged(){
            if placeName.text?.isEmpty == false {
                saveButton.isEnabled = true
            } else {
                saveButton.isEnabled = false
            }
        }
    }
    
    // MARK: - Work with Image
    
    extension NewPlaceTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        func chooseInagePicker(sourse: UIImagePickerController.SourceType) {
            if UIImagePickerController.isSourceTypeAvailable(sourse) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true // позволяет пользователю редактировать изображения
                imagePicker.sourceType = sourse
                present(imagePicker, animated: true)
            }
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            placeImage.image = info[.editedImage] as? UIImage
            placeImage.contentMode = .scaleAspectFill
            placeImage.clipsToBounds = true
            imageIsChanged = true
            dismiss(animated: true)
            
        }
    }

