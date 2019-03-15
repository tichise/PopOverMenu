### PopOverMenu

PopOverMenu is a PopOver style menu.

### Image
#### iPhone
<img src="https://user-images.githubusercontent.com/43707/29257422-db4db7e6-80ec-11e7-9a42-cd75a06ca73c.png" width="400px">

### Examples

#### Swift

Basic
```html
    public func openMenu(sender:UIBarButtonItem) {
        let titles = ["Menu1", "Menu2", "Menu3"]
        let descriptions = ["description1", "description2", "description3"]
        
        let popOverViewController = PopOverViewController.instantiate()
        popOverViewController.set(titles: titles)
        popOverViewController.set(descriptions: descriptions)

        // option parameteres
        // popOverViewController.set(selectRow: 1)
        // popOverViewController.set(showsVerticalScrollIndicator: true)
        // popOverViewController.set(separatorStyle: UITableViewCellSeparatorStyle.singleLine)

        popOverViewController.popoverPresentationController?.barButtonItem = sender
        popOverViewController.preferredContentSize = CGSize(width: 300, height:135)
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

    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
```

Array
```html
    func openMenu(view :UIView) {
        let popOverViewController = PopOverViewController.instantiate()

        let titles = [ "Menu1", "Menu2", "Menu3"]
        let keys = [1, 2, 3]

        popOverViewController?.setArrayForView(delegate: self, view: view, titles: titles, keys: keys, defaultKey: selectedIntKey) { (key, index) in

            self.selectedIntKey = key

            print("key is  \(String(describing: key)) , index is  \(index) ")
        }

        self.present(popOverViewController, animated: true) {() -> Void in }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
```

Array / with all
```html
    func openMenu(view :UIView) {
        let popOverViewController = PopOverViewController.instantiate()

        let titles = ["Menu1", "Menu2", "Menu3"]
        let keys = [1, 2, 3]
        let allName = "All"

        popOverViewController?.setArrayForView(delegate: self, view: view, titles: titles, keys: keys, defaultKey: selectedIntKey, allName: allName, onSelected: { (key, index) in
            self.selectedIntKey = key

            print("key is  \(String(describing: key)) , index is  \(index) ")
        })

        self.present(popOverViewController, animated: true) {() -> Void in }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
```

Enum
```html
    func openMenu(view :UIView) {
        let popOverViewController = PopOverViewController.instantiate()
        let allName = "All"

        popOverViewController?.setEnumForView(delegate: self, view: view, enumType: FoodName.self, defaultEnum: selectedFoodName, allName: allName, onSelected: { (key, index) in
            print("key is  \(String(describing: key)) , index is  \(index) ")

            if index == 0 {
                self.selectedFoodName = nil
            } else {

                self.selectedFoodName = key

                let foodValue = unsafeBitCast(key, to: FoodValue.self)
                print(foodValue.rawValue)
            }
        })

        self.present(popOverViewController, animated: true) {() -> Void in }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
```

UIBarButtonItem
One step
```html
    func openMenu(sender: UIBarButtonItem) {
        let popOverViewController = PopOverViewController.instantiate()

        let titles = ["Menu1", "Menu2", "Menu3"]

        self.popOverViewController?.setArrayForBarButtonItem(delegate: self, barButtonItem: sender, titles: titles, separatorStyle: .singleLine) { (selectRow) in
            self.textLabel?.text = String(selectRow)
        }

        present(popOverViewController, animated: true, completion: nil)
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
```

Two step
```html
    func openMenu(sender: UIBarButtonItem) {
        let popOverViewController = PopOverViewController.instantiate()

        let titles = ["Menu1", "Menu2", "Menu3"]
        let descriptions = ["description1", "description2", "description3"]

        self.popOverViewController?.setArrayForBarButtonItem(delegate: self, barButtonItem: sender, titles: titles, descriptions: descriptions, separatorStyle: .none) { (selectRow) in
            self.textLabel?.text = String(selectRow)
        }

        present(popOverViewController, animated: true, completion: nil)
    }

    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
```

#### ObjectiveC

```
@import PopOverMenu;

-(IBAction)openMenu:(id)sender {
    
    NSArray *titles = @[@"Menu1", @"Menu2", @"Menu3"];
    NSArray *descriptions = @[@"description1", @"", @"description3"];
    
    PopOverViewController *popOverViewController = [PopOverViewController instantiate];
    
    [popOverViewController setTitles:titles];
    [popOverViewController setDescriptions:descriptions];
    
    popOverViewController.popoverPresentationController.barButtonItem = sender;
    popOverViewController.preferredContentSize = CGSizeMake(300, 135);
    popOverViewController.presentationController.delegate = self;
    
    [popOverViewController setCompletionHandler:^(NSInteger selectRow) {
        switch (selectRow) {
            case 0:
                break;
            case 1:
                break;
            case 2:
                break;
            default:
                break;
        }
    }];
    
    [self presentViewController:popOverViewController animated:YES completion:nil];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone;
}
```

### Installation (CocoaPods)
`pod PopOverMenu`

### CocoaPods URL
- [PopOverMenu on CocoaPods.org](https://cocoapods.org/pods/PopOverMenu)

### License
PopOverMenu is available under the MIT license. See the LICENSE file for more info.
