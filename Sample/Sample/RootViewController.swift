//
//  RootViewController
//  Sample
//

import UIKit
import PopOverMenu

class RootViewController: UITableViewController, UIAdaptivePresentationControllerDelegate {

    var popOverViewController: PopOverViewController?
    var section1 = ["Int Array",  "String Array", "Int Array（All selectable）"]
    var section2 = ["Enum",  "Enum（All selectable）"]
    var section3 = ["UIBarButtonItem"]

    var selectedIntKey: Int? = nil
    var selectedStringKey: String? = nil
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
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return section1.count
        } else if section == 1 {
            return section2.count
        } else if section == 2 {
            return section3.count
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)

            let text = section2[indexPath.row]
            cell.textLabel!.text = text
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoveCell", for: indexPath)

            let text = section3[indexPath.row]
            cell.textLabel!.text = text
            return cell
        }

        return UITableViewCell.init()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        guard let contentView = cell?.contentView else {
            return
        }

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                openIntArrayMenu(view: contentView)
            } else if indexPath.row == 1 {
                openStringArrayMenu(view: contentView)
            } else if indexPath.row == 2 {
                openIntArrayMenu(view: contentView, allName: "All")
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                openEnumMenu(view: contentView)
            } else if indexPath.row == 1 {
                openEnumMenu(view: contentView, allName: "All")
            }
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - function

    func openIntArrayMenu(view :UIView) {
        self.popOverViewController = PopOverViewController.instantiate()

        let titles = [ "Menu1", "Menu2", "Menu3"]
        let keys = [1, 2, 3]

        self.popOverViewController?.setArrayForView(delegate: self, view: view, titles: titles, keys: keys, defaultKey: selectedIntKey) { (key, index) in

            self.selectedIntKey = key

            print("key is  \(String(describing: key)) , index is  \(index) ")
        }

        if let popOverViewController = self.popOverViewController {
            self.present(popOverViewController, animated: true) {() -> Void in }
        }
    }

    func openStringArrayMenu(view :UIView) {
        self.popOverViewController = PopOverViewController.instantiate()

        let titles = [ "Menu1", "Menu2", "Menu3"]
        let keys = ["menu1", "menu2", "menu3"]

        self.popOverViewController?.setArrayForView(delegate: self, view: view, titles: titles, keys: keys, defaultKey: selectedStringKey) { (key, index) in

            self.selectedStringKey = key

            print("key is  \(String(describing: key)) , index is  \(index) ")
        }

        if let popOverViewController = self.popOverViewController {
            self.present(popOverViewController, animated: true) {() -> Void in }
        }
    }

    func openIntArrayMenu(view :UIView, allName: String) {
        self.popOverViewController = PopOverViewController.instantiate()

        let titles = ["Menu1", "Menu2", "Menu3"]
        let keys = [1, 2, 3]

        self.popOverViewController?.setArrayForView(delegate: self, view: view, titles: titles, keys: keys, defaultKey: selectedIntKey, allName: allName, onSelected: { (key, index) in
            self.selectedIntKey = key

            print("key is  \(String(describing: key)) , index is  \(index) ")
        })

        if let popOverViewController = self.popOverViewController {
            self.present(popOverViewController, animated: true) {() -> Void in }
        }
    }

    // MARK: - Enum

    func openEnumMenu(view :UIView) {
        self.popOverViewController = PopOverViewController.instantiate()

        self.popOverViewController?.setEnumForView(delegate: self, view: view, enumType: FoodName.self, defaultEnum: selectedFoodName, onSelected: { (key, index)  in

            self.selectedFoodName = key

            let foodValue = unsafeBitCast(key, to: FoodValue.self)
            print(foodValue.rawValue)

            print("key is  \(String(describing: key)) , index is  \(index) ")
        })

        if let popOverViewController = self.popOverViewController {
            self.present(popOverViewController, animated: true) {() -> Void in }
        }
    }

    func openEnumMenu(view :UIView, allName: String) {
        self.popOverViewController = PopOverViewController.instantiate()

        self.popOverViewController?.setEnumForView(delegate: self, view: view, enumType: FoodName.self, defaultEnum: selectedFoodName, allName: allName, onSelected: { (key, index) in
            print("key is  \(String(describing: key)) , index is  \(index) ")

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
