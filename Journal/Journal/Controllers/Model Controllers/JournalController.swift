//
//  JournalController.swift
//  Journal
//
//  Created by River McCaine on 1/12/21.
//

import Foundation

class JournalController {
    
    // MARK: - Shared Instance
    static let shared = JournalController()
    
    // MARK: - Source of Truth
    var journals: [Journal] = []
    
    // MARK: - CRUD
    // Create
    func createJournalWith(newTitle: String) {
        let newJournal = Journal(title: newTitle)
        journals.append(newJournal)
        //Save
    }
    
    //Delete
    func delete(journalToDelete: Journal ) {
        //Index for deletion
        guard let index = journals.firstIndex(of: journalToDelete) else { return }
        //Remove
        journals.remove(at: index)
        //Save
        saveToPersistenceStore()
    }
    
    func addEntryTo(journal: Journal, entry: Entry) {
        journal.entries.append(entry)
        //Save
        saveToPersistenceStore()
    }
    
    func removeEntryFrom(journal: Journal, entry: Entry) {
        guard let index = journal.entries.firstIndex(of: entry) else { return }
        journal.entries.remove(at: index)
        //Save
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
            let data = try JSONEncoder().encode(journals)
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
            let foundJournals = try JSONDecoder().decode([Journal].self, from: data)
            journals = foundJournals
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
} // End of class
