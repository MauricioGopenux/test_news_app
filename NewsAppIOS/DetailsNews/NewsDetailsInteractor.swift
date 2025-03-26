//
//  NewsDetailsInteractor.swift
//  NewsAppIOS
//
//  Created by Radmas on 26/03/25.
//
class NewsDetailsInteractor {
    private var newsRepository: NewsRepository!
    private var newsDetailsPresenter: NewsDetailsPresenterProtocol?
    
    func setNewsRepository(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }
    
    func setNewsPresenter(newsDetailsPresenter: NewsDetailsPresenterProtocol) {
        self.newsDetailsPresenter = newsDetailsPresenter
    }
    
    func updateFavorite(news: News) {
        newsRepository.updateNews(news: news)
        newsDetailsPresenter?.updateListNews()
    }
}
