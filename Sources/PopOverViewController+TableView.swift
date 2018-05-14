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
        
        // If explanation text is coming, display it in two lines
        if (descriptions == nil) {
            cell = tableView.dequeueReusableCell(withIdentifier: "SingleTitleCell")!
            cell.textLabel?.text = title
        } else {
            let description:String? = descriptions?[indexPath.row]

            if (description?.count)! > 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "SubTitleCell")!
                
                cell.textLabel?.text = title
                cell.detailTextLabel?.text = description
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "SingleTitleCell")!
                cell.textLabel?.text = title
            }
        }
        
        if (selectRow == nil) {
            cell.accessoryType = UITableViewCellAccessoryType.none
        } else {
            cell.accessoryType = selectRow == indexPath.row ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
        }

        return cell
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
}
