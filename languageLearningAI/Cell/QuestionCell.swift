//
//  QuestionCell.swift
//  languageLearningAI
//
//  Created by MQF-6 on 21/02/25.
//

import UIKit

class QuestionCell: UITableViewCell {

    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var tblOption: TableOption!
    @IBOutlet weak var tblOptionHeight: NSLayoutConstraint!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tblOptionHeight.constant = self.tblOption.contentSize.height
    }

    func configureData(questionData: Quiz) {
        lblQuestion.text = questionData.question
        tblOption.selected = questionData.selectedAns
        tblOption.optionData = questionData.options ?? []
        tblOption.reloadData()
        
        DispatchQueue.main.async {
            self.tblOptionHeight.constant = self.tblOption.contentSize.height
            self.tblOption.layoutIfNeeded()
        }
    }
}
