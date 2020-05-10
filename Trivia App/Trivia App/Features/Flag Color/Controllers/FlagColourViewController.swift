//
//  FlagColourViewController.swift
//  Trivia App
//
//  Created by Sasi Raj on 09/05/20.
//

import UIKit

class FlagColourViewController: UIViewController {

    @IBOutlet weak var flagTableView: UITableView!
    var flagColorsArray = [flagColors]()
    var selectedColors = [String]()
     var objDetails:Details?
    override func viewDidLoad() {
        super.viewDidLoad()
        flagTableView.delegate = self
        flagTableView.dataSource = self
        flagTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        initalSetup()
    }
    
    func initalSetup() {
        var obj = flagColors(flag: "White", isSelected: false)
        flagColorsArray.append(obj)
        obj = flagColors(flag: "yellow", isSelected: false)
        flagColorsArray.append(obj)
        obj = flagColors(flag: "orange", isSelected: false)
        flagColorsArray.append(obj)
        obj = flagColors(flag: "green", isSelected: false)
        flagColorsArray.append(obj)
        
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        if selectedColors.count<1 {
            showToast(message: "Please select flag Colours", seconds: 2)
            return
        }
        objDetails?.flagColor = selectedColors
         let summary : SummaryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SummaryVC") as! SummaryVC
        summary.objDetails = objDetails
        self.navigationController!.pushViewController(summary, animated: true)
    }
    
}
extension FlagColourViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        flagColorsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.colorTxt.text = flagColorsArray[indexPath.row].flag
        switch indexPath.row {
        case 0:
            cell.bgView.backgroundColor = UIColor.white
        case 1:
        cell.bgView.backgroundColor = UIColor.yellow
        case 2:
        cell.bgView.backgroundColor = UIColor.orange
        case 3:
        cell.bgView.backgroundColor = UIColor.green
        default:
            cell.bgView.backgroundColor = UIColor.white
        }
        if flagColorsArray[indexPath.row].isSelected {
            cell.colorTxt.textColor = UIColor.blue
            cell.bgView.layer.borderWidth = 5
            cell.bgView.layer.borderColor = UIColor.blue.cgColor
        } else {
            cell.colorTxt.textColor = UIColor.black
            cell.bgView.layer.borderWidth = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if flagColorsArray[indexPath.item].isSelected {
            flagColorsArray[indexPath.item].isSelected = false
            selectedColors = selectedColors.filter{$0 != flagColorsArray[indexPath.item].flag }
        } else {
            flagColorsArray[indexPath.item].isSelected = true
            selectedColors.append(flagColorsArray[indexPath.item].flag)
        }
        flagTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
}
extension FlagColourViewController {
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
