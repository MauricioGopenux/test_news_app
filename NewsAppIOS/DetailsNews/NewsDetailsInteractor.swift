//
//  NewsDetailsInteractor.swift
//  NewsAppIOS
//
//  Created by Radmas on 25/03/25.
//
class NewsDetailsInteractor {
    private var newsRepository: NewsRepository!
    private var listNewsInteractor: ListNewsInteractor!
    
    func setNewsRepository(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }
    
    func setListNewsInteractor(listNewsInteractor: ListNewsInteractor) {
        self.listNewsInteractor = listNewsInteractor
    }
    
    func updateFavorite(news: News) {
        newsRepository.updateNews(news: news)
        listNewsInteractor.updateListNews()
    }
}
