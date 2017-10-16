//
//  PopOverViewController
//

import Foundation

open class PopOverViewController: UITableViewController, UIAdaptivePresentationControllerDelegate {
    
    fileprivate var titles:Array<String> = []
    fileprivate var descriptions:Array<String>?
    @objc open var completionHandler: ((_ selectRow: Int) -> Void)?
    fileprivate var selectRow:Int?
    
    fileprivate var separ:Int?
    
    fileprivate var separatorStyle: UITableViewCellSeparatorStyle = UITableViewCellSeparatorStyle.none
    fileprivate var showsVerticalScrollIndicator:Bool = false
    
    @objc open static func instantiate() -> PopOverViewController {
        let storyboardsBundle = getStoryboardsBundle()
        let storyboard:UIStoryboard = UIStoryboard(name: "PopOver", bundle: storyboardsBundle)
        let popOverViewController:PopOverViewController = storyboard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        
        popOverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
        popOverViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        
        // arrow color
        popOverViewController.popoverPresentationController?.backgroundColor = UIColor.white
        
        return popOverViewController
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 45
        tableView.tableFooterView = UIView()
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        tableView.separatorStyle = separatorStyle
        tableView.accessibilityIdentifier = "PopUpTableView"

    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
        if (selectRow != nil) {
            let selectIndexPath:IndexPath = IndexPath(row: selectRow!, section: 0)
            tableView.scrollToRow(at: selectIndexPath, at: .middle, animated: true)
        }
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - table
    
    override open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        let title:String? = titles[indexPath.row]
        
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
    
    @objc open func setTitles(_ titles:Array<String>) {
        self.titles = titles
    }
    
    @objc open func setDescriptions(_ descriptions:Array<String>) {
        self.descriptions = descriptions
    }
    
    @objc open func setSelectRow(_ selectRow:Int) {
        self.selectRow = selectRow
    }
    
    @objc open func setSeparatorStyle(_ separatorStyle:UITableViewCellSeparatorStyle) {
        self.separatorStyle = separatorStyle
    }
    
    @objc open func setShowsVerticalScrollIndicator(_ showsVerticalScrollIndicator:Bool) {
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
    }
    
    /**
     * didSelectRowAtIndexPath
     */
    override open func tableView(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.dismiss(animated: true, completion: {
            if self.completionHandler != nil {
                let selectRow:Int = indexPath.row
                self.completionHandler!(selectRow)
            }
        })
    }
    
    static func getStoryboardsBundle() -> Bundle {
        let podBundle = Bundle(for: PopOverViewController.self)
        let bundleURL = podBundle.url(forResource: "Storyboards", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        
        return bundle
    }
}
