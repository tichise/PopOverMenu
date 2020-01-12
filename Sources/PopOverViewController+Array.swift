//
//  PopOverViewController+Array.swift
//

extension PopOverViewController {

    open func setArrayForView<T: Comparable>(delegate:UIAdaptivePresentationControllerDelegate, view: UIView, titles: [String]?, keys: [T]?, defaultKey: T?, allName: String, separatorStyle: UITableViewCell.SeparatorStyle, onSelected: @escaping (_ key:T?, _ index: Int) -> ()) {

        guard let titles = titles else {
            return
        }

        guard let keys = keys else {
            return
        }

        var mutableTitles: [String] = titles
        var mutableKeys: [T?] = keys

        mutableTitles.insert(allName, at: 0)
        mutableKeys.insert(nil, at: 0)

        setArrayForView(delegate: delegate, view: view, titles: mutableTitles, keys: mutableKeys, defaultKey: defaultKey, separatorStyle: separatorStyle) { (key, index) in
            onSelected(key, index)
        }
    }

    open func setArrayForView<T: Comparable>(delegate:UIAdaptivePresentationControllerDelegate, view: UIView, titles: [String]?, keys: [T?]?, defaultKey: T?, separatorStyle: UITableViewCell.SeparatorStyle, onSelected: @escaping (_ key: T?, _ index: Int) -> ()) {

        guard let titles = titles else {
            return
        }

        guard let keys = keys else {
            return
        }

        self.set(showsVerticalScrollIndicator: true)
        self.set(separatorStyle: separatorStyle)
        self.set(titles: titles)
        self.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any

        self.set(selectRow: 0)

        if let defaultKey = defaultKey {
            for (index, key) in keys.enumerated() {
                if key == defaultKey {
                    self.set(selectRow: index)
                }
            }
        }

        self.popoverPresentationController?.sourceView = view
        self.popoverPresentationController?.sourceRect = view.bounds

        let menuHeight = getMenuHeight(view: self.view, titles: titles)
        self.preferredContentSize = CGSize(width: 300, height: menuHeight)
        self.presentationController?.delegate = delegate
        self.completionHandler = {(_ selectRow: Int) -> Void in
            let key = keys[selectRow]
            onSelected(key, selectRow)
        }
    }
}
