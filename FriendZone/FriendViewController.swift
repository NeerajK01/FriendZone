//
//  FriendViewController.swift
//  FriendZone
//
//  Created by Neeraj kumar on 04/02/21.
//  Copyright © 2021 prolifics. All rights reserved.
//

import UIKit

class FriendViewController: UITableViewController, Storyboarded {

    weak var delegate = ViewController()
    var friend: Friends!
    
    var timeZone = [TimeZone]()
    var selectedTimeZone = -1
    
    var nameEditingCell: TextViewCell? {
        let indexPath = IndexPath(row: 0, section: 0)
        return tableView.cellForRow(at: indexPath) as? TextViewCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let identifiers = TimeZone.knownTimeZoneIdentifiers
        
        for identifier in identifiers{
            if let timezone = TimeZone(identifier: identifier){
                timeZone.append(timezone)
            }
        }
        
        let now = Date()
        
        timeZone.sort(by: { (one, two) in
            let ourDiff = one.secondsFromGMT(for: now)
            let otherDiff = two.secondsFromGMT(for: now)
            
            if ourDiff == otherDiff{
                return one.identifier < two.identifier
            }else{
                return ourDiff < otherDiff
            }
            
        })
        
        selectedTimeZone = timeZone.firstIndex(of: friend.timeZon) ?? -1

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.updateFriend(fiend: friend)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return 1
        }else{
            return timeZone.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Name your friend"
        }else{
            return "Select their TimeZone"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Name", for: indexPath) as? TextViewCell else{
                fatalError("Couldn't get a tableview table view cell")
            }
            cell.nameTXT.text = friend.name
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeZone", for: indexPath)
            let timezoneValue = timeZone[indexPath.row]
            
            cell.textLabel?.text = timezoneValue.identifier.replacingOccurrences(of: "_", with: " ")
            
            let timeDiff = timezoneValue.secondsFromGMT(for: Date())
            cell.detailTextLabel?.text = timeDiff.timeString()
            if indexPath.row == selectedTimeZone{
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            startEditing()
        }else{
            selectRow(at: indexPath)
        }
    }
    
    func startEditing(){
        nameEditingCell?.nameTXT.becomeFirstResponder()
    }
    
    func selectRow(at indexPath: IndexPath){
        nameEditingCell?.nameTXT.resignFirstResponder()
        
        for cell in tableView.visibleCells{
            cell.accessoryType = .none
        }
        
        selectedTimeZone = indexPath.row
        friend.timeZon = timeZone[indexPath.row]
        
        let selected = tableView.cellForRow(at: indexPath)
        selected?.accessoryType = .checkmark
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    @IBAction func nameChanged(_ sender: UITextField) {
        friend.name = sender.text ?? ""
    }
    
    
}
