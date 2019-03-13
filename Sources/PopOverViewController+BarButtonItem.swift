//
//  PopOverViewController+BarButtonItem.swift
//

extension PopOverViewController {

    open func setArrayForBarButtonItem(delegate: UIAdaptivePresentationControllerDelegate, barButtonItem: UIBarButtonItem, titles: [String], descriptions: [String], onSelected: @escaping (_ index: Int) -> Void) {

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
}
