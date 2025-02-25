//
//  SearchResultViewController.swift
//  MSShopping
//
//  Created by 강민수 on 1/15/25.
//

import UIKit

final class SearchResultViewController: UIViewController {
    
    private let searchResultView = SearchResultView()
    private let viewModel: SearchResultViewModel
    private let input: SearchResultViewModel.Input
    private let output: SearchResultViewModel.Output
    
    private let viewDidLoadSubject: CustomObservable<Void> = CustomObservable(())
    private let selectedFilterButtonDidTapSubject: CustomObservable<FilterButton.FilterButtonType> = CustomObservable(.accuracy)
    private let didRequestMoreResultSubject: CustomObservable<Void> = CustomObservable(())
    
    init(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
        self.input = SearchResultViewModel.Input(
            viewDidLoad: viewDidLoadSubject,
            selectedFilterButtonDidTap: selectedFilterButtonDidTapSubject,
            didRequestMoreResult: didRequestMoreResultSubject
        )
        self.output = viewModel.transform(from: input)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBind()
        setupAddTargetButton()
        setupCollectionView()
        viewDidLoadSubject.send(())
    }
    
    private func setupBind() {
        output.indicatorAnimate.bind { [weak self] isAnimate in
            guard let self else { return }
            if isAnimate {
                searchResultView.indicatorView.startAnimating()
            } else {
                searchResultView.indicatorView.stopAnimating()
            }
        }
        
        output.productTotalCountText.bind { [weak self] text in
            guard let self else { return }
            searchResultView.searchTotalCountLabel.text = text
        }
        
        output.searchProductArrayUpdate.bind { [weak self] _ in
            guard let self else { return }
            searchResultView.productCollectionView.reloadData()
        }
        
        output.alertError.bind { [weak self] alertTitle in
            guard let self else { return }
            presentDefaultAlert(alertTitle: alertTitle)
        }
    }
    
    private func setupAddTargetButton() {
        searchResultView.filterButtonArray.forEach {
            $0.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
        }
    }
    
    private func setupCollectionView() {
        searchResultView.productCollectionView.delegate = self
        searchResultView.productCollectionView.dataSource = self
        searchResultView.productCollectionView.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.identifier
        )
    }
    
    @objc private func filterButtonDidTap(_ sender: UIButton) {
        let buttonType = FilterButton.FilterButtonType(rawValue: sender.tag) ?? .accuracy
        selectedFilterButtonDidTapSubject.send(buttonType)
        searchResultView.productCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        searchResultView.filterButtonArray.forEach { $0.isSelected = false }
        sender.isSelected = true
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchProductArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCollectionViewCell.identifier,
            for: indexPath
        ) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(viewModel.searchProductArray[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.searchProductArray.count - 3  == indexPath.item {
            didRequestMoreResultSubject.send(())
        }
    }
}
