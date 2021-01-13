//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by River McCaine on 1/11/21.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate  {
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Properties
    var entry: Entry?
    var journal: Journal?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        // Do any additional setup after loading the view.
        updateViews()
        
    }

    
    // MARK: - Actions
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty,
              let journal = journal else { return }
        

        EntryController.createEntryWith(newTitle: title, newBody: body, journal: journal)
        dismiss(animated: true, completion: nil)
        JournalController.shared.saveToPersistenceStore()
        navigationController?.popViewController(animated: true)

// save
    }
    
    // MARK: - Helper Functions
    func updateViews() {
        guard let sentEntry = entry else { return }
        titleTextField.text = sentEntry.title
        bodyTextView.text = sentEntry.body
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
    }
    
}
