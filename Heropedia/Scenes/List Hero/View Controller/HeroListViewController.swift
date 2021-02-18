//
//  HeroListViewController.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 15/02/21.
//

import UIKit
import Toast

protocol HeroListViewPresentationProtocol: class {
    func showHero()
    func reloadData()
    func showError()
    func showInternetConnectionProblemMessage()
}

final class HeroListViewController: UIViewController {
    
    // MARK:- View
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.register(
            HeroCell.self,
            forCellReuseIdentifier: HeroCell.cellIdentifier
        )
        
        tableView.register(
            ErrorStateCell.self,
            forCellReuseIdentifier: ErrorStateCell.identifier
        )
        
        return tableView
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(
            HeroCollectionFilterCell.self,
            forCellWithReuseIdentifier: HeroCollectionFilterCell.identifier
        )
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK:- Properties
    private let presenter: HeroListPresenter
    
    enum State {
        case initial
        case error
        case populated
    }
    
    private(set) var state: State = .error {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK:- Initializer
    init(presenter: HeroListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK:- Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchHero()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startNetworkMonitoring()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopNetworkMonitoring()
    }
    
    // MARK:- Private functions
    private func fetchHero() {
        presenter.loadHero()
        presenter.fetchHero()
    }
    
    private func startNetworkMonitoring() {
        presenter.startNetworkMonitoring()
    }
    
    private func stopNetworkMonitoring() {
        presenter.stopNetworkMonitoring()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        
        collectionView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            paddingTop: 12,
            paddingLeft: 12,
            paddingBottom: 0,
            paddingRight: 12,
            width: 0,
            height: 50
        )
        
        tableView.anchor(
            top: collectionView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            paddingTop: 16,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0,
            width: 0,
            height: 0
        )
    }
}

// MARK:- UITableViewDelegate & UITableViewDataSource Implementation
extension HeroListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state == .populated ? presenter.filteredHeroes.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .error:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ErrorStateCell.identifier, for: indexPath) as? ErrorStateCell else {
                return UITableViewCell()
            }
            
            cell.reload = { [weak self] in
                self?.fetchHero()
            }
            
            return cell
            
        case .populated:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeroCell.cellIdentifier, for: indexPath) as? HeroCell else {
                return UITableViewCell()
            }
            
            let hero = presenter.filteredHeroes[indexPath.row]
            cell.bindViewWith(data: hero)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return state == .populated ? 100.0 : tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard state == .populated else {
            return
        }
        
        presenter.didSelectHeroAt(index: indexPath.row)
    }
    
}

// MARK:- UICollectionViewDelegate & UICollectionViewDataSource Implementation
extension HeroListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.roles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroCollectionFilterCell.identifier, for: indexPath) as? HeroCollectionFilterCell else {
            return UICollectionViewCell()
        }
        
        let role = presenter.roles[indexPath.item]
        cell.isSelected = role == presenter.selectedRole
        cell.renderViewBy(role: role)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !presenter.roles.isEmpty else {
            return
        }
        
        presenter.filterHeroWith(role: presenter.roles[indexPath.item])
    }
}

// MARK:- HeroListViewPresentationProtocol Implementation
extension HeroListViewController: HeroListViewPresentationProtocol {
    func showHero() {
        state = .populated
    }
    
    func showError() {
        state = .error
    }
    
    func reloadData() {
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    func showInternetConnectionProblemMessage() {
        view.makeToast("No internet connection")
    }
}
