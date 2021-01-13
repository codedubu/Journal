//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by River McCaine on 1/11/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {
   // MARK: - Outlets
    
    // MARK: - Properties
    var journal: Journal?
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        guard let entry = journal?.entries[indexPath.row] else { return cell }
        // text label formatter
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timeStamp.dateToSTring()
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let journal = journal else { return }
            let entryToDelete = journal.entries[indexPath.row]
            EntryController.deleteEntry(entry: entryToDelete, journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? EntryDetailViewController,
              let journal = journal else { return }
        if segue.identifier == "toEntryDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let entryToSend = journal.entries[indexPath.row]
            destination.journal = journal
            destination.entry = entryToSend
        } else if segue.identifier == "createNewEntry" {
            destination.journal = journal
        }
        
        
        
        //IIDOO
        //Identifier
//        if segue.identifier == "toEntryDetailVC" {
//            //Index
//            if let selectedIndex = tableView.indexPathForSelectedRow {
//                //Destination
//                if let detailViewController = segue.destination as? EntryDetailViewController {
//                    //Object to send
//                    let entry = journal?.entries[selectedIndex.row]
//                    //Object to receive
//                    detailViewController.entry = entry
//
//                    // The destination of the book is the book at the selectedIndex.row
//                }
//            }
//        }
    }
        
}
