//
//  SummaryVC.swift
//  Trivia App
//
//  Created by Sasi Raj on 10/05/20.
//

import UIKit
import CoreData

class SummaryVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var crcLbl: UILabel!
    @IBOutlet weak var flagLbl: UILabel!
    var flagStr = ""
    var objDetails:Details?
    var item : [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        setup()
    }
    
    @IBAction func finish(_ sender: Any) {
        
        if let details = objDetails {
            save(date: details.currDate, name: details.name, cricName: details.crickterName, flagColors: flagStr)
        }
        
        // Mark:- remove all view controllers from the stack after saving
        if let viewControllerCount = self.navigationController?.viewControllers.count {
            self.navigationController?.viewControllers.removeFirst(viewControllerCount - 1)
        }
        let rootVC : ViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController!.pushViewController(rootVC, animated: true)
        
    }
    
    func setup(){
        if let details = objDetails {
            nameLbl.text = "Hello \(details.name)"
            crcLbl.text = "Answer: \(details.crickterName)"
            flagStr = "Answer: \(details.flagColor[0])"
            for index in 1..<details.flagColor.count {
                flagStr = flagStr + ", \(details.flagColor[index])"
            }
            flagLbl.text = flagStr
        }
//        print(objDetails)
        
    }
    
    func save(date:String,name:String,cricName:String,flagColors:String) {
        
        guard let appDelegate = UIApplication.shared.delegate as! AppDelegate?
            else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Model", in: managedContext)!
        let product = NSManagedObject(entity: entity, insertInto: managedContext)
        
        product.setValue(date, forKey: "date")
        product.setValue(name, forKey: "name")
        product.setValue(cricName, forKey: "cricName")
        product.setValue(flagColors, forKey: "flagColours")
        product.setValue(item.count + 1, forKey: "gameCount")
        do {
            try managedContext.save()
        } catch {
            print("Cannot be Saved")
        }
    }
    
    func fetch() {
        guard let appDelegate = UIApplication.shared.delegate as! AppDelegate?
            else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Model")
        do {
            try self.item = managedContext.fetch(fetchRequest)
        } catch {
            print("Could not Fetch the result")
        }
    }
    
}

