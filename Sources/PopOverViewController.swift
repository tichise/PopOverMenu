//
//  PopOverViewController
//

import Foundation

open class PopOverViewController: UITableViewController, UIAdaptivePresentationControllerDelegate {
    
    var titles: [String] = []
    var descriptions: [String]?
    @objc open var completionHandler: ((_ selectRow: Int) -> Void)?
    var selectRow:Int?
    var separ:Int?
    
    var titleLabelFont: UIFont = UIFont.systemFont(ofSize: 15)
    var detailLabelFont: UIFont = UIFont.systemFont(ofSize: 10)
    var cellHeight: CGFloat = 45

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
        
        tableView.rowHeight = UITableView.automaticDimension
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
    
    @objc open func set(titles: [String]) {
        self.titles = titles
    }
    
    @objc open func set(descriptions: [String]) {
        self.descriptions = descriptions
    }
    
    @objc open func set(cellHeight: CGFloat) {
        self.cellHeight = cellHeight
    }
    
    @objc open func set(selectRow: Int) {
        self.selectRow = selectRow
    }
    
    @objc open func set(separatorStyle: UITableViewCell.SeparatorStyle) {
        self.separatorStyle = separatorStyle
    }
    
    @objc open func set(titleTextLabelFont: UIFont) {
        self.titleTextLabelFont = titleTextLabelFont
    }
    
    @objc open func set(detailTextLabelFont: UIFont) {
        self.detailTextLabelFont = detailTextLabelFont
    }
    
    @objc open func set(showsVerticalScrollIndicator: Bool) {
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
    }
    
    static func getStoryboardsBundle() -> Bundle {
        let podBundle = Bundle(for: PopOverViewController.self)
        let bundleURL = podBundle.url(forResource: "PopOverMenuStoryboards", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        
        return bundle
    }
}
