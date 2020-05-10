//
//  TableViewCell.swift
//  Trivia App
//
//  Created by Sasi Raj on 10/05/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var colorTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        bgView.layer.cornerRadius = 40
    }
    
}
