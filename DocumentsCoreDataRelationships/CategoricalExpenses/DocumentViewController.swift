//
//  DocumentsViewController.swift
//  Document
//
//  Created by Shawn Moore on 11/6/17.
//  Copyright © 2017 Shawn Moore. All rights reserved.
//

import UIKit

class DocumentsViewController: UIViewController {

    @IBOutlet weak var DocumentsTableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    //Intially we have it set to no categroy at all which means
    //it will start as nil first
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.documentsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewDocument(_ sender: Any) {
        performSegue(withIdentifier: "showDocument", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? NewDocumentViewController else {
            return
        }
        
        destination.category = category
    }
    
    func deleteDocument(at indexPath: IndexPath) {
        guard let ocument = category?.documents?[indexPath.row],
            let managedContext = document.managedObjectContext else {
                return
        }
        
        managedContext.delete(document)
        
        do {
            try managedContext.save()
            
            documentsTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Could not delete document")
            
            documentsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension DocumentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //logic is that if category DNE, return 0, if documents DNE then return 0
        //and if they both exist then return count
        return category?.documents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = documentsTableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)
        
        if let document = category?.documents?[indexPath.row] {
            cell.textLabel?.text = document.name
            
            if let date = document.date {
                cell.detailTextLabel?.text = dateFormatter.string(from: date)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteDocument(at: indexPath)
        }
    }
}

extension DocumentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDocument", sender: self)
    }
}


