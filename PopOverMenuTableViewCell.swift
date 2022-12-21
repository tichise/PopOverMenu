//
//  PopOverMenuTableViewCell.swift
//  PopOverMenu
//
//  Created by ChanLi on 04/12/2020.
//

import UIKit

class PopOverMenuTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRect.init(x: 0, y: textLabel?.frame.origin.y ?? 0, width: frame.width, height: textLabel?.frame.height ?? 0)
        detailTextLabel?.frame = CGRect.init(x: 0, y: detailTextLabel?.frame.origin.y ?? 0, width: frame.size.width, height: detailTextLabel?.frame.size.height ?? 0)
    }
}
