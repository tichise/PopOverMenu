//
//  PopOverViewController+BarButtonItem.swift
//

extension PopOverViewController {

    open func setArrayForBarButtonItem(delegate: UIAdaptivePresentationControllerDelegate, barButtonItem: UIBarButtonItem, titles: [String], descriptions: [String], separatorStyle: UITableViewCell.SeparatorStyle, onSelected: @escaping (_ index: Int) -> Void) {

        let cellHeight: Int = 60
        let tableHeight: CGFloat = CGFloat(cellHeight * titles.count)

        self.set(separatorStyle: separatorStyle)
        self.set(titles: titles)
        self.set(descriptions: descriptions)
        self.set(titleLabelFont: UIFont.systemFont(ofSize: 16))
        self.set(detailLabelFont: UIFont.systemFont(ofSize: 12))
        self.set(cellHeight: 60)

        self.popoverPresentationController?.barButtonItem = barButtonItem

        let adjustmentHeight: CGFloat = separatorStyle == .none ? 0 : 1

        self.preferredContentSize = CGSize(width: 300, height: tableHeight - adjustmentHeight)
        self.presentationController?.delegate = delegate
        self.completionHandler = {(_ selectRow: Int) -> Void in
            onSelected(selectRow)
        }
    }

    open func setArrayForBarButtonItem(delegate: UIAdaptivePresentationControllerDelegate, barButtonItem: UIBarButtonItem, titles: [String], separatorStyle: UITableViewCell.SeparatorStyle, onSelected: @escaping (_ index: Int) -> Void) {

        self.set(titles: titles)
        self.set(separatorStyle: separatorStyle)

        self.popoverPresentationController?.barButtonItem = barButtonItem

        let menuHeight = getMenuHeight(view: self.view, titles: titles)

        let adjustmentHeight: CGFloat = separatorStyle == .none ? 0 : 1
        self.preferredContentSize = CGSize(width: 300, height: menuHeight - adjustmentHeight)
        self.presentationController?.delegate = delegate
        self.completionHandler = {(_ selectRow: Int) -> Void in
            onSelected(selectRow)
        }
    }
}
