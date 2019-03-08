//
//  RootViewController
//  Sample
//

import UIKit
import PopOverMenu

class RootViewController: UITableViewController, UIAdaptivePresentationControllerDelegate {

    var popOverViewController: PopOverViewController?
    var section1 = ["View : Array", "View : Enum"]
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
                openMenuForArray(view: contentView)
            } else if indexPath.row == 1 {
                openMenuForEnum(view: contentView)
            }
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    func openMenuForArray(view :UIView) {
        self.popOverViewController = PopOverViewController.instantiate()

        let titles = ["Menu1", "Menu2", "Menu3", "Menu1", "Menu2", "Menu3"]
        let keys = [1, 2, 3, 1, 2, 3]

        self.popOverViewController?.setPopOverMenu(delegate: self, view: view, titles: titles, keys: keys, selectedKey: selectedKey) { (key) in
            self.selectedKey = key
        }

        if let popOverViewController = self.popOverViewController {
            self.present(popOverViewController, animated: true) {() -> Void in }
        }
    }

    func openMenuForEnum(view :UIView) {
        self.popOverViewController = PopOverViewController.instantiate()

        self.popOverViewController?.setPopOverMenu(delegate: self, view: view, enumType: FoodName.self, selectedValue: selectedFoodName, onSelected: { (selectedFoodName) in

            self.selectedFoodName = selectedFoodName

            let foodValue = unsafeBitCast(selectedFoodName, to: FoodValue.self)
            print(foodValue.rawValue)
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
