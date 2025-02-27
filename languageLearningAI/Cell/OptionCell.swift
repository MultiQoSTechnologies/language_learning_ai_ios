//
//  OptionCell.swift
//  languageLearningAI
//
//  Created by MQF-6 on 21/02/25.
//

import UIKit

class OptionCell: UITableViewCell {
    @IBOutlet weak var lblOptionTitle: UILabel!
    @IBOutlet weak var btnRadio: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(option: Option, index: Int, selected: String) {
        if index == 0 {
            lblOptionTitle.text = option.a
            btnRadio.isSelected = selected == "a"
        } else if index == 1 {
            lblOptionTitle.text = option.b
            btnRadio.isSelected = selected == "b"
        } else if index == 2 {
            lblOptionTitle.text = option.c
            btnRadio.isSelected = selected == "c"
        } else {
            lblOptionTitle.text = option.d
            btnRadio.isSelected = selected == "d" 
        }
    }
}
