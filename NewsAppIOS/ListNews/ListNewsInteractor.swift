//
//  ListNewsInteractor.swift
//  NewsAppIOS
//
//  Created by Radmas on 21/03/25.
//
import Foundation

class ListNewsInteractor {
    private var newsRepository: NewsRepository!
    private var newsPresenter: NewsPresenterProtocol?
    private var showFavorites: Bool = true
    
    func setNewsRepository(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }
    
    func setNewsPresenter(newsPresenter: NewsPresenterProtocol) {
        self.newsPresenter = newsPresenter
    }
    
    func syncNews() {
        Task {
            let news: [News] = await newsRepository.syncNews()
            newsRepository.saveNewsList(newsList: news)
            await thereFavoriteNews()
        }
    }
    
    @MainActor
    func thereFavoriteNews() {
        showFavorites = !getNewsFavorites().isEmpty
        newsPresenter?.selectTabItem(favorite: showFavorites)
        applyFilter(favorite: showFavorites)
    }
    
    func applyFilter(favorite: Bool) {
        let news: [News] =  favorite ? getNewsFavorites(): newsRepository.getNews()
        newsPresenter?.newsLoaded(news: news)
    }
    
    func getNewsFavorites() -> [News]{
        newsRepository.getNews().filter {$0.favorite == true}
    }
    
    func updateListNews(favorite: Bool) {
        if favorite != showFavorites {
            showFavorites = favorite
            applyFilter(favorite: showFavorites)
        }
    }
    
    func updateFavoriteNews() {
        if showFavorites {
            applyFilter(favorite: showFavorites)
        }
    }
}
