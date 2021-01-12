//
//  Entry Controller.swift
//  Journal
//
//  Created by River McCaine on 1/11/21.
//

import Foundation

class EntryController {
    // Shared Instance
    static let shared = EntryController()
    
    // Source of Truth
    var entries: [Entry] = []
    
    // CRUD Methods
    //Create
    func createEntryWith(newTitle: String, newBody: String, newTimeStamp: Date = Date()) {
        let newEntry = Entry(title: newTitle, body: newBody, timeStamp: newTimeStamp)
        entries.append(newEntry)
        // TODO: save
        saveToPersistenceStore()
    }
    //Read
    //Update
    
    //Delete
    func deleteEntry(entryToDelete: Entry) {
        // Find the index
        guard let index = entries.firstIndex(of: entryToDelete) else { return }
        // remove an entry
        entries.remove(at: index)
        // TODO: Save
        saveToPersistenceStore()
    }
    
    // MARK: - Data Persistence
    // fileURL
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Journal.json")
        return fileURL
    }
    
    //save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    //load
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: fileURL())
            let foundEntries = try JSONDecoder().decode([Entry].self, from: data)
            entries = foundEntries
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }

    
} //End of class
