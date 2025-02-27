//
//  TableOption.swift
//  languageLearningAI
//
//  Created by MQF-6 on 21/02/25.
//

import UIKit

class TableOption: UITableView {
    
    var optionData = [Option]()
    var selected: String?
    var selctedOptions: DataBind<String?> = DataBind<String?>(nil)
 
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

extension TableOption: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell") as? OptionCell else {
            return UITableViewCell()
        }
        
        let item = optionData[indexPath.row]
        cell.configureCell(option: item, index: indexPath.row, selected: selected ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            selctedOptions.value = "a"
            
        case 1:
            selctedOptions.value = "b"
            
        case 2:
            selctedOptions.value = "c"
            
        case 3:
            selctedOptions.value = "d"
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
