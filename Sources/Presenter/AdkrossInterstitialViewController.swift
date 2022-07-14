//
//  AdkrossInterstitialViewController.swift
//  
//
//  Created by Furkan Kaplan on 14.07.2022.
//

import UIKit

protocol AdkrossInterstitialViewControllerDelegate: AnyObject {
    func adkrossInterstitialViewControllerDissmised()
    func adkrossInterstitialViewControllerTapped()
}
class AdkrossInterstitialViewController: UIViewController {

    @IBOutlet weak var ctaButton: UIButton!
    
    private let adkrossInstance: Adkross
    private let ad: CampaignLoadModel.Response
    private unowned let delegate: AdkrossInterstitialViewControllerDelegate
    
    init(
        adkrossInstance: Adkross,
        ad: CampaignLoadModel.Response,
        delegate: AdkrossInterstitialViewControllerDelegate
    ) {
        self.adkrossInstance = adkrossInstance
        self.ad = ad
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        configureBackgroundView()
        configureCallToActionButton()
    }
    
}

// MARK: - UI Configuration Methods

extension AdkrossInterstitialViewController {
    
    private func configureBackgroundView() {
        view.backgroundColor = .insterstitialBackgroundColor
    }
    
    private func configureCallToActionButton() {
        ctaButton.layer.cornerRadius = 16
        ctaButton.backgroundColor = .white
        ctaButton.titleLabel?.font = .boldSystemFont(ofSize: 25)
        ctaButton.setTitleColor(.black, for: .normal)
        ctaButton.setTitle("Visit App on App Store", for: .normal)
    }
    
}
