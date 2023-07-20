//
//  AdkrossInterstitialViewController.swift
//  
//
//  Created by Furkan Kaplan on 14.07.2022.
//

import UIKit
import Kingfisher

protocol AdkrossInterstitialViewControllerDelegate: AnyObject {
    func adkrossInterstitialViewControllerDissmised()
    func adkrossInterstitialViewControllerTapped()
    func adkrossInterstitialAdFired(with event: EventType)
    func adkrossInterstitialAdFiredFailed(with message: String, evenType: EventType)
}
class AdkrossInterstitialViewController: UIViewController {
    @IBOutlet weak private var blurBackgroundView: UIView!
    @IBOutlet weak private var backgroundImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var callToActionButton: UIButton!
    @IBOutlet weak private var adkrossButton: UIButton!

    private let adkrossInstance: Adkross
    private let ad: CampaignLoad.Response
    private unowned let delegate: AdkrossInterstitialViewControllerDelegate

    init(
        adkrossInstance: Adkross,
        ad: CampaignLoad.Response,
        delegate: AdkrossInterstitialViewControllerDelegate
    ) {
        self.adkrossInstance = adkrossInstance
        self.ad = ad
        self.delegate = delegate
        super.init(nibName: nil, bundle: .module)
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        configureBackgroundImage()
        configureAdkrossButton()
        configureTitleLabel()
        configureDescriptionLabel()
        configureCallToActionButton()
    }
    
    @IBAction private func dismissButtonTapped(
        _ sender: Any
    ) {
        dismiss(animated: true)
        fireEvent(with: .CLOSE)
    }

    @IBAction private func adkrossButtonTapped(
        _ sender: Any
    ) {
        guard let adkrossUrl = URL.adkrossURL else {
            return
        }

        UIApplication.shared.open(adkrossUrl)
    }

    @IBAction private func callToActionButtonTapped(
        _ sender: Any
    ) {
        guard let storeUrl = ad.campaign?.storeUrl else {
            return
        }

        dismiss(animated: true) {
            UIApplication.shared.open(storeUrl)
            self.fireEvent(with: .CLICK)
        }
    }
}

// MARK: - Network Calls

private extension AdkrossInterstitialViewController {

    func fireEvent(
        with event: EventType
    ) {
        adkrossInstance.fireEvent(
            campaignKey: ad.campaign?.id ?? "",
            analyticEventType: event
        ) { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .success:
                self.delegate.adkrossInterstitialAdFired(
                    with: event
                )
            case .failure(let message):
                self.delegate.adkrossInterstitialAdFiredFailed(
                    with: message,
                    evenType: event
                )
            }
        }
    }
}

// MARK: - UI Configuration Methods

private extension AdkrossInterstitialViewController {

    func configureTitleLabel() {
        titleLabel.text = ad.campaign?.title
        titleLabel.font = .header
    }

    func configureDescriptionLabel() {
        descriptionLabel.text = ad.campaign?.description
        descriptionLabel.font = .body
    }

    func configureBackgroundImage() {
        backgroundImageView.kf.setImage(with: ad.campaign?.campaignImageUrl)
        blurBackgroundView.backgroundColor = .insterstitialBackgroundColor
    }

    func configureAdkrossButton() {
        adkrossButton.setTitle("Adkross Ad", for: .normal)
        adkrossButton.titleLabel?.font = .small
        adkrossButton.imageView?.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
        adkrossButton.setTitleColor(.adkrossGreen, for: .normal)
        adkrossButton.tintColor = .adkrossGreen
    }

    func configureCallToActionButton() {
        callToActionButton.layer.cornerRadius = 9
        callToActionButton.backgroundColor = .adkrossGreen
        callToActionButton.titleLabel?.font = .caption
        callToActionButton.setTitleColor(.white, for: .normal)
        callToActionButton.setTitle(ad.campaign?.ctaText, for: .normal)
    }
}
