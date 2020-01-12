//
//  SampleViewController
//  Sample
//
//  Copyright © 2017年 ichise. All rights reserved.
//

import UIKit
import PopOverMenu

enum Drink: String, CaseIterable {
    case coffee
    case water
    case milk
    case tea
}

class SampleViewController: UIViewController, UIAdaptivePresentationControllerDelegate {

    let separatorStyle: UITableViewCell.SeparatorStyle = .singleLine

    var popOverViewController: PopOverViewController?

    @IBOutlet weak var textLabel: UILabel?
    
    var selectedDrink = Drink.water

    override func viewDidLoad() {
        super.viewDidLoad()

        let barButtonItem = UIBarButtonItem(title: "menu", style: .plain, target: self, action: #selector(SampleViewController.openMenu(sender:)))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func openMenu(sender: UIBarButtonItem) {
        self.popOverViewController = PopOverViewController.instantiate()

        let titles = ["Menu1", "Menu2", "Menu3"]
        let descriptions = ["description1", "description2", "description3"]

        self.popOverViewController?.setArrayForBarButtonItem(delegate: self, barButtonItem: sender, titles: titles, descriptions: descriptions, separatorStyle: separatorStyle) { (selectRow) in
            self.textLabel?.text = String(selectRow)
        }

        if let popOverViewController = self.popOverViewController {
            present(popOverViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func openMenuAboutDrink(sender: UIButton) {
        
        self.popOverViewController = PopOverViewController.instantiate()
        
        guard let popOverViewController = popOverViewController else {
            return
        }
        
        popOverViewController.setEnumForView(delegate: self, view: sender, enumType: Drink.self, defaultEnum: selectedDrink, separatorStyle: .none) { (key, index) in
            
            guard let key = key else {
                return
            }
            
            self.selectedDrink = key
            
            switch (key) {
            case .water:
                self.textLabel?.text = "water"
                break
            case .coffee:
                self.textLabel?.text = "coffee"
                break
            case .milk:
                self.textLabel?.text = "milk"
                break
            case .tea:
                 self.textLabel?.text = "tea"
                 break
            default:
                break
            }
        }
        
        self.present(popOverViewController, animated: true) {() -> Void in }
    }

    // 画面回転時によばれる
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { context in
            self.popOverViewController?.dismiss(animated: true)
        })
    }

    // iPhone でもポップオーバーを表示するためには、下記の delegate メソッドで常に UIModalPresentationNone を返すようにします。
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    // これを入れないと、iPhone PlusでLandscape時にPopOverMenuがModal表示される
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
