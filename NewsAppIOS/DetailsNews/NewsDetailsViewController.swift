//
//  NewsDetailsViewController.swift
//  NewsAppIOS
//
//  Created by Radmas on 25/03/25.
//
import UIKit

protocol DetailViewProtocol: AnyObject {
    func showNewsDetails(news: News)
}

class NewsDetailsViewController: UIViewController {
    private var newsDetailPresenter: NewsDetailsPresenter!

    @IBOutlet private weak var NewsImageView: UIImageView!
    @IBOutlet private weak var favoriteSwitch: UISwitch!
    @IBOutlet private weak var descriptionNews: UITextView!
    @IBOutlet private weak var titleNews: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        newsDetailPresenter.showNews()
    }
    
    private func setTitle() {
        title = "Detalles"
    }

    @IBAction func didTapFavorite(_ sender: Any) {
        newsDetailPresenter.updateFavorite(favorite: favoriteSwitch.isOn)
    }
    
    func setNewsDetailsPresenter(newsDetailPresenter: NewsDetailsPresenter) {
        self.newsDetailPresenter = newsDetailPresenter
    }
}

extension NewsDetailsViewController: DetailViewProtocol {
    func showNewsDetails(news: News) {
        titleNews.text = news.title
        descriptionNews.text = news.description
        favoriteSwitch.isOn = news.favorite
        if let urlString = news.imageURL, let url = URL(string: urlString) {
                  loadImage(from: url)
              } else {
                  NewsImageView.image = UIImage(named: "placeholder")
              }
          }

    private func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.NewsImageView.image = image
                }
            }
        }
    }
}
