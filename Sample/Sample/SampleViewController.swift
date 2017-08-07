//
//  SampleViewController
//  Sample
//
//  Copyright © 2017年 ichise. All rights reserved.
//

import UIKit
import PopOverMenu

class SampleViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    
    @IBOutlet var baseTextView:UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButtonItem:UIBarButtonItem = UIBarButtonItem(title: "menu", style: .plain, target: self, action: #selector(SampleViewController.openMenu(sender:)))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    public func openMenu(sender:UIBarButtonItem) {
        let titles:NSArray = ["Menu1", "Menu2", "Menu3"]
        let descriptions:NSArray = ["description1", "", "description3"]
        
        let popOverViewController = PopOverViewController.instantiate()
        popOverViewController.setTitles(titles: titles)
        popOverViewController.setDescriptions(descriptions: descriptions)
        popOverViewController.popoverPresentationController?.barButtonItem = sender
        popOverViewController.preferredContentSize = CGSize(width: 300, height:129)
        popOverViewController.presentationController?.delegate = self
        popOverViewController.completionHandler = { selectRow in
            switch (selectRow) {
            case 0:
                break
            case 1:
                break
            case 2:
                break
            default:
                break
            }
            
        };
        present(popOverViewController, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

