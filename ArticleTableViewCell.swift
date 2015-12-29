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
    @IBOutlet weak var myRssTitle: UILabel!

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
        self.myRssTitle.text = article.rssTitle
        do {
            let url = NSURL(string:article.imageUrl!);
            let imageData = try NSData(contentsOfURL:url!,options: NSDataReadingOptions.DataReadingMappedIfSafe);
            let img = UIImage(data:imageData);
            let resized = resizeImage(img!, toTheSize: CGSizeMake(80, 80))
            self.myImage.image = resized
        } catch {
            self.myImage.image = nil
            print("Warn: Cannot create image")
        }
    }

    func resizeImage(image:UIImage, toTheSize size:CGSize) -> UIImage {
        let scale = CGFloat(max(size.width/image.size.width, size.height/image.size.height))
        let width:CGFloat  = image.size.width * scale
        let height:CGFloat = image.size.height * scale
        let rr:CGRect = CGRectMake( 0, 0, width, height);

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image.drawInRect(rr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

}
