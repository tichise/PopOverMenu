//
//  PopOverViewController
//

import Foundation

extension PopOverViewController {
    
    override open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        let title = titles[indexPath.row]
        
        if isDescriptions() {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "SubTitleCell")!
            
            cell.textLabel?.text = title
            cell.textLabel?.font = titleLabelFont
            cell.textLabel?.sizeToFit()
            
            if let descriptions = self.descriptions {
                let description = descriptions[indexPath.row]
                
                cell.detailTextLabel?.text = description
                cell.detailTextLabel?.font = detailLabelFont
                cell.detailTextLabel?.sizeToFit()
            }
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "SingleTitleCell")!
            cell.textLabel?.text = title
            cell.textLabel?.font = titleLabelFont
            cell.textLabel?.sizeToFit()
        }
        
        if (selectRow == nil) {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        } else {
            cell.accessoryType = selectRow == indexPath.row ? UITableViewCell.AccessoryType.checkmark : UITableViewCell.AccessoryType.none
        }

        return cell
    }
    
    private func isDescriptions() -> Bool {
        guard let descriptions = self.descriptions else {
            return false
        }
        
        if descriptions.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    override open func tableView(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.dismiss(animated: true, completion: {
            if let handler = self.completionHandler {
                let selectRow = indexPath.row
                handler(selectRow)
            }
        })
    }
    
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
