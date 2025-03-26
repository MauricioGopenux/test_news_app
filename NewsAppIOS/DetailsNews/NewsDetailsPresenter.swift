//
//  NewsDetailsPresenter.swift
//  NewsAppIOS
//
//  Created by Radmas on 25/03/25.
//
protocol NewsDetailsPresenterProtocol: AnyObject {
    func updateListNews()
}

final class NewsDetailsPresenter {
    private var detailViewProtocol: DetailViewProtocol?
    private var newsDetailsInteractor: NewsDetailsInteractor!
    private var newsPresenterProtocol : UpdateNewsPresenterProtocol?
    private var news: News!
    
    func setNews(news: News) {
        self.news = news
    }
    
    func setDetailViewProtocol(detailViewProtocol: DetailViewProtocol) {
        self.detailViewProtocol = detailViewProtocol
    }
    
    func setNewsDetailsInteractor(newsDetailsInteractor: NewsDetailsInteractor) {
        self.newsDetailsInteractor = newsDetailsInteractor
    }
    
    func setListNewsPresenter(newsPresenterProtocol : UpdateNewsPresenterProtocol) {
        self.newsPresenterProtocol = newsPresenterProtocol
    }
    
    func showNews() {
        detailViewProtocol?.showNewsDetails(news: news)
    }
    
    func updateFavorite(favorite: Bool) {
        news.favorite = favorite
        newsDetailsInteractor.updateFavorite(news: news)
    }
}

extension NewsDetailsPresenter: NewsDetailsPresenterProtocol {
    func updateListNews() {
        newsPresenterProtocol?.updateFavoriteListNews()
    }
}
