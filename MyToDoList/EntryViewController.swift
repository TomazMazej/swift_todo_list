//
//  EntryViewController.swift
//  MyToDoList
//
//  Created by Tomaz Mazej on 16/02/2021.
//

import RealmSwift
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Open keyboard for textfield
        textField.becomeFirstResponder()
        textField.delegate = self
        
        // We set date picker to today
        datePicker.setDate(Date(), animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    
    // Get rid of the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func didTapSaveButton(){
        if let text = textField.text, !text.isEmpty{
            let date = datePicker.date
            
            realm.beginWrite()
            let newItem = ToDoListItem()
            newItem.date = date
            newItem.item = text
            realm.add(newItem)
            try! realm.commitWrite()
            
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
        }
        else{
            print("Add")
        }
    }
}
