//
//  TableQuizQuestion.swift
//  languageLearningAI
//
//  Created by MQF-6 on 21/02/25.
//

import UIKit

class TableQuizQuestion: UITableView {
    
    var questionData = [Quiz]()
    var selected: [Quiz] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialization()
    }
 
    private func initialization() {
        self.delegate = self
        self.dataSource = self
        self.sectionHeaderTopPadding = 0
        self.reloadData()
    }

}


extension TableQuizQuestion: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as? QuestionCell else {
            return UITableViewCell()
        }
        
        let item = questionData[indexPath.row]
        cell.tblOption.selctedOptions.value = nil
        if let index = selected.firstIndex(where: { $0.question == item.question}) {
            cell.configureData(questionData: selected[index])
        } else {
            cell.configureData(questionData: item)
        }
        cell.tblOption.selctedOptions.subscribe { [weak self] optionStr in
            
            guard let self = self,
                  let optionStr = optionStr else {
                      return
                  }
            
            if let index = selected.firstIndex(where: { $0.question == item.question}) {
                selected[index].selectedAns = optionStr
            } else {
                var selectedItem = item
                selectedItem.selectedAns = optionStr
                self.selected.append(selectedItem)
            }
            
            self.reloadData()
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
