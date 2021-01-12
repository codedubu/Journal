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
        guard let entryTitle = titleTextField.text, !entryTitle.isEmpty,
              let bodyText = bodyTextView.text, !bodyText.isEmpty else { return }
        
        EntryController.shared.createEntryWith(newTitle: entryTitle, newBody: bodyText)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        updateViews()
        EntryController.shared.saveToPersistenceStore()
        
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
