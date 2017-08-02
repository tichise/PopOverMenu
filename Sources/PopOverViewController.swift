//
//  PopOverViewController
//

import Foundation

public class PopOverViewController: UITableViewController, UIAdaptivePresentationControllerDelegate {
    
    private var titles:Array<String> = []
    private var descriptions:Array<String> = []
    public var completionHandler: ((_ selectRow: Int) -> Void)?
    
    public static func instantiate() -> PopOverViewController {
        let storyboardsBundle = getStoryboardsBundle()
        let storyboard:UIStoryboard = UIStoryboard(name: "PopOver", bundle: storyboardsBundle)
        let popOverViewController:PopOverViewController = storyboard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        
        popOverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
        popOverViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        
        // arrow color
        popOverViewController.popoverPresentationController?.backgroundColor = UIColor.white
        
        return popOverViewController
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 45
        tableView.tableFooterView = UIView()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: { _ in })
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - table
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        let description:String? = descriptions[indexPath.row]
        let title:String? = titles[indexPath.row]
        
        // If explanation text is coming, display it in two lines
        if (description?.characters.count)! > 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "SubTitleCell")!

            cell.textLabel?.text = title
            cell.detailTextLabel?.text = description
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "SingleTitleCell")!
            cell.textLabel?.text = title
        }

        return cell
    }
    
    
    /**
     * didSelectRowAtIndexPath
     */
    override public func tableView(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.dismiss(animated: true, completion: {
            if self.completionHandler != nil {
                let selectRow:Int = indexPath.row
                self.completionHandler!(selectRow)
            }
        })
    }
    
    public func setTitles(titles:NSArray) {
        self.titles = titles as! Array<String>
    }
    
    public func setDescriptions(descriptions:NSArray) {
        self.descriptions = descriptions as! Array<String>
    }
    
    static func getStoryboardsBundle() -> Bundle {
        let podBundle = Bundle(for: PopOverViewController.self)
        let bundleURL = podBundle.url(forResource: "Storyboards", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        
        return bundle
    }
}
