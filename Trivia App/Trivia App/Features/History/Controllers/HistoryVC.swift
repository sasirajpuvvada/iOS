//
//  HistoryVC.swift
//  Trivia App
//
//  Created by Sasi Raj on 10/05/20.
//

import UIKit
import CoreData

class HistoryVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var item : [NSManagedObject] = []
    var objDetails:Details?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetch()
    }
    
    func fetch() {
        guard let appDelegate = UIApplication.shared.delegate as! AppDelegate?
            else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Model")
        do {
            try self.item = managedContext.fetch(fetchRequest)
            print(item)
        } catch {
            print("Could not Fetch the result")
        }
    }

}
extension HistoryVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(item[indexPath.row])
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        cell.detailTextLabel?.text = item[indexPath.item].value(forKey: "date") as? String
        cell.textLabel?.text = item[indexPath.item].value(forKey: "name") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let name = item[indexPath.item].value(forKey: "name") as? String,
        let game = item[indexPath.item].value(forKey: "date") as? String,
        let flag = item[indexPath.item].value(forKey: "flagColours") as? String,
        let cricName = item[indexPath.item].value(forKey: "cricName") as? String,
        let count = item[indexPath.item].value(forKey: "gameCount") as? Int
        else { return }
       
        let historyDetials : HistoryDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryDetailsVC") as! HistoryDetailsVC
        historyDetials.nameStr = name
        historyDetials.flagName = flag
        historyDetials.cricName = cricName
        historyDetials.gameStr = game
        historyDetials.count = "\(count)"
        self.navigationController!.pushViewController(historyDetials, animated: true)
        
    }
    
}
