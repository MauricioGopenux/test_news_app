//
//  ListNewsCell.swift
//  NewsAppIOS
//
//  Created by Radmas on 21/03/25.
//

import UIKit

class ListNewsCell: UITableViewCell {

    @IBOutlet private weak var titleNewsLabel: UILabel!
    @IBOutlet private weak var newsImageView: UIImageView!
    
    func config(news: News) {
        titleNewsLabel.text = news.title
        if let urlString = news.imageURL, let url = URL(string: urlString) {
                  loadImage(from: url)
              } else {
                  newsImageView.image = UIImage(named: "placeholder")
              }
    }
    
    private func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.newsImageView.image = image
                }
            }
        }
    }
}
