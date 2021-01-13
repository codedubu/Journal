//
//  Entry Controller.swift
//  Journal
//
//  Created by River McCaine on 1/11/21.
//

import Foundation

class EntryController {

    // CRUD Methods
    //Create
    static func createEntryWith(newTitle: String, newBody: String, newTimeStamp: Date = Date(), journal: Journal) {
        let newEntry = Entry(title: newTitle, body: newBody, timeStamp: newTimeStamp)
        JournalController.shared.addEntryTo(journal: journal, entry: newEntry)
    }
    //Read
    //Update
    
    //Delete
    static func deleteEntry(entry: Entry, journal: Journal) {
        // Find the index
        JournalController.shared.removeEntryFrom(journal: journal, entry: entry)

    }
    
    static func update(entry: Entry, title: String, body: String) {
        entry.title = title
        entry.body = body
        JournalController.shared.saveToPersistenceStore()
    }

    
} //End of class
