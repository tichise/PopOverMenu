//
//  PopOverViewController+Enum.swift
//

extension PopOverViewController {

    public func setEnumForView<T: CaseIterable & RawRepresentable & Hashable>(delegate: UIAdaptivePresentationControllerDelegate, view: UIView, enumType: T.Type, defaultEnum: T?, allName: String, separatorStyle: UITableViewCell.SeparatorStyle, onSelected: @escaping (_ key: T?, _ index: Int) -> ()) {

        let baseTitles = enumType.allCases.map{$0.rawValue}

        guard var titles = baseTitles as? [String] else {
            return
        }

        titles.insert(allName, at: 0)

        guard let allCases = enumType.allCases as? [T] else {
            return
        }

        self.set(showsVerticalScrollIndicator: true)
        self.set(separatorStyle: separatorStyle)
        self.set(titles: titles)
        self.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any

        if let selectedEnum = defaultEnum {
            guard let index = allCases.firstIndex(of: selectedEnum) else {
                return
            }

            self.set(selectRow: index+1)
        } else {
            self.set(selectRow: 0)
        }

        self.popoverPresentationController?.sourceView = view
        self.popoverPresentationController?.sourceRect = view.bounds

        let menuHeight = getMenuHeight(view: self.view, titles: titles)
        self.preferredContentSize = CGSize(width: 300, height: menuHeight)
        self.presentationController?.delegate = delegate
        self.completionHandler = {(_ selectRow: Int) -> Void in
            if selectRow == 0 {
                onSelected(nil, selectRow)
            } else {
                let key = allCases[selectRow-1]
                onSelected(key, selectRow)
            }
        }
    }

    public func setEnumForView<T: CaseIterable & RawRepresentable & Hashable>(delegate: UIAdaptivePresentationControllerDelegate, view: UIView, enumType: T.Type, defaultEnum: T?, separatorStyle: UITableViewCell.SeparatorStyle, onSelected: @escaping (_ key: T?, _ index: Int) -> ()) {

        let baseTitles = enumType.allCases.map{$0.rawValue}

        guard let titles = baseTitles as? [String] else {
            return
        }

        guard let allCases = enumType.allCases as? [T] else {
            return
        }

        self.set(showsVerticalScrollIndicator: true)
        self.set(separatorStyle: separatorStyle)
        self.set(titles: titles)
        self.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any

        if let selectedEnum = defaultEnum {
            guard let index = allCases.firstIndex(of: selectedEnum) else {
                return
            }

            self.set(selectRow: index)
        } else {
            self.set(selectRow: 0)
        }

        self.popoverPresentationController?.sourceView = view
        self.popoverPresentationController?.sourceRect = view.bounds

        let menuHeight = getMenuHeight(view: self.view, titles: titles)
        self.preferredContentSize = CGSize(width: 300, height: menuHeight)
        self.presentationController?.delegate = delegate
        self.completionHandler = {(_ selectRow: Int) -> Void in
            let key = allCases[selectRow]
            onSelected(key, selectRow)
        }
    }
}
