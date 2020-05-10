//
//  ViewController.swift
//  Trivia App
//
//  Created by Sasi Raj on 09/05/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameValidationLbl: UILabel!
    @IBOutlet weak var nameTxtField: UITextField!
    var date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        self.date = formattedDate
        
        // removing last view controller from stack when data is stored in previous execution
        if let viewControllerCount = self.navigationController?.viewControllers.count {
            self.navigationController?.viewControllers.removeFirst(viewControllerCount - 1)
        }
        
    }

    @IBAction func historyButton(_ sender: Any) {
        let historyVC : HistoryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC
        self.navigationController!.pushViewController(historyVC, animated: true)
    }
    @IBAction func historyBtn(_ sender: Any) {
        
    }
    
    @IBAction func startBtn(_ sender: Any) {
        
        if let name = nameTxtField.text, name.count > 0 {
            
            let objDetails = Details(name: name, crickterName: "", flagColor: [""],currDate: self.date)
            let secondVC : CrickterViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CrickterViewController") as! CrickterViewController
            
            secondVC.objDetails = objDetails
            
            self.navigationController!.pushViewController(secondVC, animated: true)
            
        } else {
            showToast(message: "Please Enter Name", seconds: 3)
            return
        }
        
    }
    

}
extension ViewController {
    func showToast(message : String, seconds: Double) {
        let toastLbl = UILabel(frame: CGRect(x: self.view.frame.width/2 - 100, y: self.view.frame.height - 100, width: 200, height: 50))
        toastLbl.text = message
        toastLbl.textAlignment = .center
        toastLbl.textColor = UIColor.black
        toastLbl.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        toastLbl.alpha = 1.0
        toastLbl.layer.cornerRadius = 30
        self.view.addSubview(toastLbl)
        
        UIView.animate(withDuration: seconds, delay: 1, options: .curveEaseInOut, animations: {
            toastLbl.alpha = 0.0
        }) { (isCompleted) in
            toastLbl.removeFromSuperview()
        }
    }
}
