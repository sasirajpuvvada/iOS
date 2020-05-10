//
//  CrickterViewController.swift
//  Trivia App
//
//  Created by Sasi Raj on 09/05/20.
//

import UIKit
class CrickterViewController: UIViewController{
    
    var cricArray = [Cricketer]()
    @IBOutlet weak var cricketerCollectionView: UICollectionView!
    var selectedValue:String = ""
    var objDetails:Details?
    override func viewDidLoad() {
        super.viewDidLoad()
        cricketerCollectionView.delegate = self
        cricketerCollectionView.dataSource = self
        initialSetup()
        cricketerCollectionView.reloadData()
        cricketerCollectionView.register(UINib(nibName: "CricketersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CricketersCollectionViewCell")
    }
    
    func initialSetup() {
        var objCricketer = Cricketer(name: "Virat Kohli", isSelected: false,image: #imageLiteral(resourceName: "vk"))
        cricArray.append(objCricketer)
        objCricketer = Cricketer(name: "Sachin Tendulkar", isSelected: false,image: #imageLiteral(resourceName: "sk"))
        cricArray.append(objCricketer)
        objCricketer = Cricketer(name: "Adam Gilchrist", isSelected: false,image: #imageLiteral(resourceName: "adam"))
        cricArray.append(objCricketer)
        objCricketer = Cricketer(name: "Jacques Khallis", isSelected: false,image: #imageLiteral(resourceName: "jk"))
        cricArray.append(objCricketer)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        if selectedValue == "" {
            showToast(message: "Please select your choice", seconds: 3)
            return
        }
        objDetails?.crickterName = selectedValue
         let thirdVC : FlagColourViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FlagColourViewController") as! FlagColourViewController
        thirdVC.objDetails = objDetails
        self.navigationController!.pushViewController(thirdVC, animated: true)
    }
    
    

}
extension CrickterViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cricArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cricketerCollectionView.dequeueReusableCell(withReuseIdentifier: "CricketersCollectionViewCell", for: indexPath) as! CricketersCollectionViewCell
        
        cell.cricketImg.image = cricArray[indexPath.item].image
        
        if cricArray[indexPath.item].isSelected {
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.blue.cgColor
        } else {
             cell.layer.borderWidth = 0
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if cricArray[indexPath.item].isSelected == true {
            cricketerCollectionView.reloadData()
            selectedValue = ""
             cricArray[indexPath.item].isSelected = false
            return
        }
        
        for (index, select) in cricArray.enumerated() {
            if select.isSelected {
                cricArray[index].isSelected = false
            }
        }

        selectedValue = cricArray[indexPath.item].name!
        cricArray[indexPath.item].isSelected = true
        cricketerCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns = 2
        let collectionViewWidth = cricketerCollectionView.frame.width
        let collectionViewHeight = cricketerCollectionView.frame.height
        let flowlayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowlayout.minimumInteritemSpacing
        let adjsutedWidth = collectionViewWidth - spaceBetweenCells
        let adjustedHeight = collectionViewHeight - flowlayout.minimumLineSpacing
        let width: CGFloat = floor(adjsutedWidth/CGFloat(columns)) - 10
        let height:CGFloat = floor(adjustedHeight/CGFloat(columns)) - 10
        return CGSize(width: width, height: height)
    }
    
    
}

extension CrickterViewController {
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
