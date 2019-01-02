//
//  PopOverViewController
//

import Foundation

open class PopOverViewController: UITableViewController, UIAdaptivePresentationControllerDelegate {
    
    var titles:Array<String> = []
    var descriptions:Array<String>?
    @objc open var completionHandler: ((_ selectRow: Int) -> Void)?
    var selectRow:Int?
    var titleTextLabelFont:UIFont = UIFont.systemFont(ofSize: 15)
    var detailTextLabelFont:UIFont = UIFont.systemFont(ofSize: 10)
    var cellHeight:CGFloat = 45
    
    var separ:Int?
    
    var separatorStyle: UITableViewCell.SeparatorStyle = UITableViewCell.SeparatorStyle.none
    var showsVerticalScrollIndicator = false
    
    @objc public static func instantiate() -> PopOverViewController {
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
        tableView.estimatedRowHeight = cellHeight
        tableView.tableFooterView = UIView()
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        tableView.separatorStyle = separatorStyle
        tableView.accessibilityIdentifier = "PopOverMenuTableView"
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
        if (selectRow != nil) {
            let selectIndexPath:IndexPath = IndexPath(row: selectRow!, section: 0)
            tableView.scrollToRow(at: selectIndexPath, at: .middle, animated: true)
        }
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc open func setTitles(_ titles:Array<String>) {
        self.titles = titles
    }
    
    @objc open func setDescriptions(_ descriptions:Array<String>) {
        self.descriptions = descriptions
    }
    
    @objc open func setCellHeight(_ cellHeight:CGFloat) {
        self.cellHeight = cellHeight
    }
    
    @objc open func setSelectRow(_ selectRow:Int) {
        self.selectRow = selectRow
    }
    
    @objc open func setSeparatorStyle(_ separatorStyle:UITableViewCell.SeparatorStyle) {
        self.separatorStyle = separatorStyle
    }
    
    @objc open func setTitleTextLabelFont(_ titleTextLabelFont:UIFont) {
        self.titleTextLabelFont = titleTextLabelFont
    }
    
    @objc open func setDetailTextLabelFont(_ detailTextLabelFont:UIFont) {
        self.detailTextLabelFont = detailTextLabelFont
    }
    
    @objc open func setShowsVerticalScrollIndicator(_ showsVerticalScrollIndicator:Bool) {
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
    }
    
    static func getStoryboardsBundle() -> Bundle {
        let podBundle = Bundle(for: PopOverViewController.self)
        let bundleURL = podBundle.url(forResource: "PopOverMenuStoryboards", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        
        return bundle
    }
}
