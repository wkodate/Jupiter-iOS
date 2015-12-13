//
//  ArticleTableViewCell.swift
//  Jupiter
//
//  Created by wkodate on 2015/12/13.
//  Copyright © 2015年 wkodate. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var imgView: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel!.text = ""
        imgView!.image = UIImage()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setCell(article: Article) {
        self.titleLabel?.text = article.title
        self.imgView?.image = UIImage(named: article.imageUrl!)
    }

}