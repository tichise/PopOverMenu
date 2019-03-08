//
//  PopOverViewController+Extension.swift
//

extension PopOverViewController {

    open func setPopOverMenu(delegate: UIAdaptivePresentationControllerDelegate, barButtonItem: UIBarButtonItem, titles: [String], descriptions: [String], onSelected: @escaping (Int) -> Void) {

        self.set(titles: titles)
        self.set(descriptions: descriptions)
        self.set(titleLabelFont: UIFont.systemFont(ofSize: 16))
        self.set(detailLabelFont: UIFont.systemFont(ofSize: 12))
        self.set(cellHeight: 60)
        self.popoverPresentationController?.barButtonItem = barButtonItem
        self.preferredContentSize = CGSize(width: 300, height: 120)
        self.presentationController?.delegate = delegate
        self.completionHandler = {(_ selectRow: Int) -> Void in
            onSelected(selectRow)
        }
    }

    open func setPopOverMenu<T: Comparable>(delegate:UIAdaptivePresentationControllerDelegate, view: UIView, titles: [String]?, keys: [T?]?, selectedKey: T?, onSelected: @escaping (T) -> ()) {

        guard let titles = titles else {
            return
        }

        guard var keys = keys else {
            return
        }

        self.set(showsVerticalScrollIndicator: true)
        self.set(separatorStyle: .singleLine)
        self.set(titles: titles)
        self.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any

        self.set(selectRow: 0)

        if let selectedKey = selectedKey {
            for (index, key) in keys.enumerated() {
                guard let key = key else {
                    break
                }

                if key == selectedKey {
                    self.set(selectRow: index)
                }
            }
        }

        self.popoverPresentationController?.sourceView = view
        self.popoverPresentationController?.sourceRect = view.frame

        let menuHeight = getMenuHeight(view: self.view, titles: titles)
        self.preferredContentSize = CGSize(width: 300, height: menuHeight)
        self.presentationController?.delegate = delegate
        self.completionHandler = {(_ selectRow: Int) -> Void in
            if let key = keys[selectRow] {
                onSelected(key)
            }
        }
    }

    open func setPopOverMenu<T: CaseIterable & RawRepresentable & Hashable>(delegate: UIAdaptivePresentationControllerDelegate, view: UIView, enumType: T.Type, selectedEnum: T?, onSelected: @escaping (_ key: T) -> ()) {

        let baseTitles = enumType.allCases.map{$0.rawValue}

        guard let titles = baseTitles as? [String] else {
            return
        }

        guard let allCases = enumType.allCases as? [T] else {
            return
        }

        self.set(showsVerticalScrollIndicator: true)
        self.set(separatorStyle: .singleLine)
        self.set(titles: titles)
        self.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any

        if let selectedEnum = selectedEnum {
            guard let index = allCases.index(of: selectedEnum) else {
                return
            }

            self.set(selectRow: index)
        } else {
            self.set(selectRow: 0)
        }

        self.popoverPresentationController?.sourceView = view
        self.popoverPresentationController?.sourceRect = view.frame

        let menuHeight = getMenuHeight(view: self.view, titles: titles)
        self.preferredContentSize = CGSize(width: 300, height: menuHeight)
        self.presentationController?.delegate = delegate
        self.completionHandler = {(_ selectRow: Int) -> Void in
            let key = allCases[selectRow]
            onSelected(key)
        }
    }

    private func getMenuHeight(view: UIView, titles: [String]) -> CGFloat {
        let menuRowsLength = CGFloat((titles.count) * 43)
        let viewHeight = view.frame.size.height
        let menumaxHeight = viewHeight - 70
        let menuHeight = menuRowsLength > menumaxHeight ? menumaxHeight : menuRowsLength

        return menuHeight
    }
}
