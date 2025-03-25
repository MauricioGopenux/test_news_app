//
//  ListNewsInteractor.swift
//  NewsAppIOS
//
//  Created by Radmas on 21/03/25.
//
class ListNewsInteractor {
    private var newsRepository: NewsRepository!
    private var newsPresenter: NewsPresenterProtocol?
    
    func setNewsRepository(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }
    
    func setNewsPresenter(newsPresenter: NewsPresenterProtocol) {
        self.newsPresenter = newsPresenter
    }
    
    func syncNews() {
           Task {
               await newsRepository.syncNews()
               loadNews()
           }
       }
    
    func loadNews() {
        var news: [News] = getNewsFavorites()
        if news.isEmpty {
            news = newsRepository.getNews()
        }
        newsPresenter?.newsLoaded(news: news)
    }
    
    func getNewsFavorites() -> [News]{
        newsRepository.getNews().filter {$0.favorite == true}
    }
    
    func applyFilter(favorite: Bool) {
        let news: [News]
        if favorite {
            news = getNewsFavorites()
        } else {
            news = newsRepository.getNews()
        }
        newsPresenter?.newsLoaded(news: news)
    }
    
    func updateListNews() {
        newsPresenter?.updateListForFilter()
    }
}
