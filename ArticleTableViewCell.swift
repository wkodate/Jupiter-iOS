//
//  ArticleTableViewCell.swift
//  Jupiter
//
//  Created by wkodate on 2015/12/19.
//  Copyright © 2015年 wkodate. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(article: Article) {
        self.myLabel.text = article.title
        do {
            let url = NSURL(string:article.imageUrl!);
            let imageData = try NSData(contentsOfURL:url!,options: NSDataReadingOptions.DataReadingMappedIfSafe);
            let img = UIImage(data:imageData);
            self.myImage.image = img
        } catch {
            self.myImage.image = nil
            print("Warn: Cannot create image")
        }
    }

}
