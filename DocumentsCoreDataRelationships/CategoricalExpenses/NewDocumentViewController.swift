//
//  NewDocumentViewController.swift
//  Document
//
//  Created by Shawn Moore on 11/6/17.
//  Copyright © 2017 Shawn Moore. All rights reserved.
//

import UIKit

class NewDocumentViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    //contentsTextField
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        amountTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        amountTextField.resignFirstResponder()
    }
    
    @IBAction func saveDocument(_ sender: Any) {
        let name = nameTextField.text
        let amountText = amountTextField.text ?? ""
        let amount = Double(amountText) ?? 0.0
        let date = datePicker.date
        
        //New instance of Document class
        if let document = Document(name: name, amount: amount, date: date) {
            category?.addToRawDocuments(document)
        }
        
        do {
            try document.managedObjectContext?.save()
            
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Document could not be created")
        }
    }
}

extension NewDocumentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
