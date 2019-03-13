//
//  RootViewController
//  Sample
//

import UIKit
import PopOverMenu

class RootViewController: UITableViewController, UIAdaptivePresentationControllerDelegate {

    var popOverViewController: PopOverViewController?
    var section1 = ["Array", "Enum", "Array（All selectable）", "Enum（All selectable）"]
    var section2 = ["UIBarButtonItem"]

    var selectedKey: Int? = nil
    var selectedFoodName: FoodName?

    @IBOutlet weak var baseTextView:UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return section1.count
        } else if section == 1 {
                return section2.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)

            let text = section1[indexPath.row]
            cell.textLabel!.text = text
            return cell

        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoveCell", for: indexPath)

            let text = section2[indexPath.row]
            cell.textLabel!.text = text
            return cell
        }

        return UITableViewCell.init()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let cell = tableView.cellForRow(at: indexPath)
            guard let contentView = cell?.contentView else {
                return
            }

            if indexPath.row == 0 {
                openArrayMenu(view: contentView)
            } else if indexPath.row == 1 {
                openEnumMenu(view: contentView)
            } else if indexPath.row == 2 {
                openArrayMenu(view: contentView, allName: "All")
            } else if indexPath.row == 3 {
                openEnumMenu(view: contentView, allName: "All")
            }
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - function

    func openArrayMenu(view :UIView) {
        self.popOverViewController = PopOverViewController.instantiate()

        let titles = [ "Menu1", "Menu2", "Menu3"]
        let keys = [1, 2, 3]

        self.popOverViewController?.setArrayForView(delegate: self, view: view, titles: titles, keys: keys, defaultKey: selectedKey) { (key, index) in

            self.selectedKey = key
        }

        if let popOverViewController = self.popOverViewController {
            self.present(popOverViewController, animated: true) {() -> Void in }
        }
    }

    func openEnumMenu(view :UIView) {
        self.popOverViewController = PopOverViewController.instantiate()

        self.popOverViewController?.setEnumForView(delegate: self, view: view, enumType: FoodName.self, defaultEnum: selectedFoodName, onSelected: { (selectedFoodName, index)  in

            self.selectedFoodName = selectedFoodName

            let foodValue = unsafeBitCast(selectedFoodName, to: FoodValue.self)
            print(foodValue.rawValue)
        })

        if let popOverViewController = self.popOverViewController {
            self.present(popOverViewController, animated: true) {() -> Void in }
        }
    }

    // MARK: - 

    func openArrayMenu(view :UIView, allName: String) {
        self.popOverViewController = PopOverViewController.instantiate()

        let titles = ["Menu1", "Menu2", "Menu3"]
        let keys = [1, 2, 3]

        self.popOverViewController?.setArrayForView(delegate: self, view: view, titles: titles, keys: keys, defaultKey: selectedKey, allName: allName, onSelected: { (key, index) in
            self.selectedKey = key
        })

        if let popOverViewController = self.popOverViewController {
            self.present(popOverViewController, animated: true) {() -> Void in }
        }
    }

    func openEnumMenu(view :UIView, allName: String) {
        self.popOverViewController = PopOverViewController.instantiate()

        self.popOverViewController?.setEnumForView(delegate: self, view: view, enumType: FoodName.self, defaultEnum: selectedFoodName, allName: allName, onSelected: { (key, index) in
            if index == 0 {
                self.selectedFoodName = nil
            } else {

                self.selectedFoodName = key

                let foodValue = unsafeBitCast(key, to: FoodValue.self)
                print(foodValue.rawValue)
            }
        })

        if let popOverViewController = self.popOverViewController {
            self.present(popOverViewController, animated: true) {() -> Void in }
        }
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

public enum FoodName: String, CaseIterable {
    case curry = "カレー"
    case sushi = "寿司"
    case ramen = "ラーメン"
}

public enum FoodValue: Int, CaseIterable {
    case curry = 1
    case sushi = 2
    case ramen = 3
}
