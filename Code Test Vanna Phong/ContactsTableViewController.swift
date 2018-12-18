//
//  ContactsTableViewController.swift
//  Code Test Vanna Phong
//
//  Created by Vanna Phong on 17/12/2018.
//  Copyright © 2018 vphong. All rights reserved.
//

import UIKit
import Contacts

class ContactsTableViewController: UITableViewController {
    
    @IBOutlet var contactsTableView: UITableView!
    
    var state = State.loading
    
    var contactStore = CNContactStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllContacts()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return state.currentContacts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return state.currentContacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell", for: indexPath) as! ContactsCell

        // Configure the cell...
        let contact = state.currentContacts[indexPath.row]
        cell.nameLabel.text = contact.givenName
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Contacts API
    private func fetchAllContacts() {
        state = .loading
        
        var contacts = [CNContact]()
        
        contactStore.requestAccess(for: .contacts) { (granted, error) in
            if let err = error {
                
            }
            
            if granted {
                // use native Contacts API
                let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
                let request = CNContactFetchRequest(keysToFetch: keys)
                do {
                    // fetch all contacts
                    try self.contactStore.enumerateContacts(with: request, usingBlock: { (contact, stop) in
                        contacts.append(contact)
                    })
                    self.state = .populated(contacts)
                } catch let err {
                    print("Error, failed to enumerate contacts: ", err)
                }
                
            } else {
                // use CoreData
            }
        }
    }
}


// MARK: Table management with State
enum State {
    case loading
    case populated([CNContact])
    case empty
    case error(Error)
    
    var currentContacts: [CNContact] {
        switch self {
        case .populated(let contacts):
            return contacts
        default:
            return []
        }
    }
}
