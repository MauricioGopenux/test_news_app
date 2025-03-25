//
//  NewsDetailsPresenter.swift
//  NewsAppIOS
//
//  Created by Radmas on 25/03/25.
//
final class NewsDetailsPresenter {
    private var detailViewProtocol: DetailViewProtocol?
    private var newsDetailsInteractor: NewsDetailsInteractor!
    private var news: News!
    
    func setNews(news: News) {
        self.news = news
    }
    
    func setDetailViewProtocol(detailViewProtocol: DetailViewProtocol) {
        self.detailViewProtocol = detailViewProtocol
    }
    
    func setListNewsInteractor(newsDetailsInteractor: NewsDetailsInteractor) {
        self.newsDetailsInteractor = newsDetailsInteractor
    }
    
    func showNews() {
        detailViewProtocol?.showNewsDetails(news: news)
    }
    
    func updateFavorite(favorite: Bool) {
        news.favorite = favorite
        newsDetailsInteractor.updateFavorite(news: news)
    }
}
