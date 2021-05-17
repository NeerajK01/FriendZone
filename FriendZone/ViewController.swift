//
//  ViewController.swift
//  FriendZone
//
//  Created by Neeraj kumar on 04/02/21.
//  Copyright © 2021 prolifics. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, Storyboarded {

    var friends = [Friends]()
    var selectedFriend: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadData()
        
        navigationItem.title = "Friend Zone"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.name
//        cell.detailTextLabel?.text = friend.timeZon.identifier
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = friend.timeZon
        dateFormatter.timeStyle = .short
        cell.detailTextLabel?.text = dateFormatter.string(from: Date())
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        configure(friend: friends[indexPath.row], position: indexPath.row)
    }

    func loadData(){
        let defaults = UserDefaults.standard
        guard let savedData = defaults.data(forKey: "Friends") else{
            return
        }
        let decoder = JSONDecoder()
        
        guard let friendData = try? decoder.decode([Friends].self, from: savedData) else{
            return
        }
        
        friends = friendData
    }
    
    func saveData(){
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        guard let savedData = try? encoder.encode(friends) else{
            fatalError("Unable to Encode friends data")
        }
        defaults.set(savedData, forKey: "Friends")
    }
    
    @objc func addFriend(){
        let friend = Friends()
        friends.append(friend)
        tableView.insertRows(at: [IndexPath(row: friends.count - 1, section: 0)], with: .automatic)
        saveData()
        
        configure(friend: friend, position: friends.count - 1)
    }
    
    func configure(friend: Friends, position: Int){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "FriendViewController") as? FriendViewController else{
            fatalError("Unable to create FriendViewController.")
        }

        selectedFriend = position
        vc.delegate = self
        vc.friend = friend
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateFriend(fiend: Friends){
        guard let selectedFriend = selectedFriend else { return }
        
        friends[selectedFriend] = fiend
        tableView.reloadData()
        saveData()
    }
}

