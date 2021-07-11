//
//  BaseViewController.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/9/21.
//

import UIKit

/**
 Enum that contains navigationbar left button types
 */
enum NavbarLeftButton {
    case BackArrow
    case None
}

/**
 Enum that contains navigationbar right button types
 */
enum NavbarRightButton {
    case cart
    case None
}

/**
 Enum that contains navigationbar shadow types
 */
enum NavbarShadowType {
    case BottomSpreadShadow
    case BottomLineShadow
    case None
}

class BaseViewController: UIViewController {
    // MARK: - Properties
    
    private var networkActivityIndicator: UIActivityIndicatorView?
    private var alertController: UIAlertController?
    
    public var animateNetworkActivityIndicator: Bool = false {
        didSet {
            networkActivityIndicatorStateChanged()
        }
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setViewBackgroundColor()
        initializeNetworkActivityIndicator()
        initializeAlertView()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - Base viewcontroller methods
    
    /**
     We can set Common Header, Footer, or Background, we can override these methods for exceptional cases.
     */
    public func setViewBackgroundColor() {
        view.backgroundColor = UIColor.iDriveWhite
    }
    
    /**
     Method to configure Navigationbar with desired properties
     To customize navigation bar call with desired parameters
     @param `navigationBarBackgroundColor` - to set navigationbar background color
     @param `navigationBarTitle` - to set navigationbar title
     @param `navigationBarLeftButtonType` - to set navigationbar left button type from the predefined set of button types
     @param `navigationBarRightButtonType` - - to set navigationbar right button type from the predefined set of button types
     @param `navigationBarButtonColor` - to set navigationbar buttons color
     @param `navigationBarShadowType` - to set navigationbar shadow type from the predefined set
     @param `navigationBarShadowColor` - to set navigationbar shadow color
     */
    public func setCustomNavigationBar(navigationBarBackgroundColor backgroundColor: UIColor = UIColor.iDriveWhite, navigationBarTitle title: String = "", navigationBarTitleColor titleColor: UIColor = UIColor.iDriveBlack, navigationBarTitleFont titleFont: UIFont = UIFont.customStyle_H2(), navigationBarLeftButtonType leftbuttonType: NavbarLeftButton = .BackArrow, navigationBarRightButtonType rightbuttonType: NavbarRightButton = .None, navigationBarButtonColor buttonColor: UIColor = UIColor.black, navigationBarShadowType shadowType: NavbarShadowType = .BottomLineShadow, navigationBarShadowColor shadowColor: UIColor = UIColor.iDriveLightGray) {
        setNavigationbarForViewControllerHidden(false)
        setNavbarColors(backgroundColor, buttonColor)
        setNavigationBarTitle(title, titleColor, titleFont)
        setNavigationBarButtons(leftbuttonType, rightbuttonType)
        setNavbarShadow(shadowType, shadowColor)
    }
    
    /**
     Method to set basic navigation bar with title and buttons
     @param `navigationBarTitle` - to set navigationbar title
     @param `navigationBarLeftButtonType` - to set navigationbar left button type from the predefined set of button types
     @param `navigationBarRightButtonType` - - to set navigationbar right button type from the predefined set of button types
     */
    public func setNavigationBar(navigationBarTitle title: String,
                                 navigationBarLeftButtonType leftbuttonType: NavbarLeftButton = .BackArrow,
                                 navigationBarRightButtonType rightbuttonType: NavbarRightButton = .None)
    {
        setNavigationbarForViewControllerHidden(false)
        
        setNavbarColors(UIColor.iDriveWhite, UIColor.iDriveBlack)
        setNavigationBarTitle(title, UIColor.iDriveBlack, UIFont.customStyle_H2())
        setNavigationBarButtons(leftbuttonType, rightbuttonType)
        setNavbarShadow(.BottomLineShadow, UIColor.iDriveLightGray)
    }
    
}

// MARK: - Navigationbar methods

extension BaseViewController {
    /**
     Method to set visibility of navbar in viewcontroller

     @param `state` - to set navigationbar hidden/show state
     */
    func setNavigationbarForViewControllerHidden(_ state: Bool) {
        navigationController?.setNavigationBarHidden(state, animated: true)
    }

    /**
     Method to set navbar colors

     @param `backgroundColor` - to set navigationbar background color
     @param `buttonColor` - to set navigationbar buttons color
     */
    private func setNavbarColors(_ backgroundColor: UIColor, _ buttonColor: UIColor) {
        navigationController?.navigationBar.barTintColor = backgroundColor
        navigationController?.navigationBar.tintColor = buttonColor
    }

    /**
     Method to set navbar shadow

     @param `shadowType` - to set navigationbar shadow type from the predefined set
     @param `shadowColor` - to set navigationbar shadow color
     */
    private func setNavbarShadow(_ shadowType: NavbarShadowType, _ shadowColor: UIColor) {
        if shadowType == .None {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.layoutIfNeeded()
        } else {
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
            navigationController?.navigationBar.layoutIfNeeded()

            var shadowOffset: CGSize!
            var shadowRadius: CGFloat!

            switch shadowType {
            case .BottomLineShadow:
                shadowOffset = CGSize(width: 1.0, height: 1.0)
                shadowRadius = 0.5
            case .BottomSpreadShadow:
                shadowOffset = CGSize(width: 2.0, height: 2.0)
                shadowRadius = 3.0
            case .None:
                break
            }
            navigationController?.navigationBar.layer.shadowColor = shadowColor.cgColor
            navigationController?.navigationBar.layer.shadowOffset = shadowOffset
            navigationController?.navigationBar.layer.shadowRadius = shadowRadius
            navigationController?.navigationBar.layer.shadowOpacity = 1.0
        }
    }

    /**
     Method to set navbar title and attributes

     @param `arg_title` - to set navigationbar title
     @param `titleColor` - to set navigationbar title color
     @param `titleFont` - to set navigationbar title font
     */
    private func setNavigationBarTitle(_ navigationBarTitle: String, _ titleColor: UIColor, _ titleFont: UIFont) {
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: titleColor,
             NSAttributedString.Key.font: titleFont]

        title = navigationBarTitle
    }

    /**
     Method to set navigationbar buttons

     @param `leftbuttonType` - to set navigationbar left button type from the predefined set of button types
     @param `rightbuttonType` - - to set navigationbar right button type from the predefined set of button types
     */
    private func setNavigationBarButtons(_ leftbuttonType: NavbarLeftButton, _ rightbuttonType: NavbarRightButton) {
        var leftbarButton = UIBarButtonItem()
        var rightbarButton = UIBarButtonItem()

        switch leftbuttonType {
        case .BackArrow:
            leftbarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .plain, target: self, action: #selector(navigationBarPopAction))
        case .None:
            break
        }

        switch rightbuttonType {
        case .cart:
            rightbarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_cart"), style: .plain, target: self, action: #selector(navigationBarRightButtonCustomAction))
        case .None:
            break
        }

        navigationItem.leftBarButtonItem = leftbarButton
        navigationItem.rightBarButtonItem = rightbarButton
    }

    // MARK: - Navbar button action methods

    /**
     Navigation bar method for pop action
     */
    @objc public func navigationBarPopAction() {
        navigationController?.popViewController(animated: true)
        navigationBarPoped()
    }

    /**
     Navigation bar method for dismiss action
     */
    @objc public func navigationBarDismissAction() {
        dismiss(animated: true) { [weak self] in
            self?.navigationBarDismissed()
        }
    }

    /**
     A custom right navbar button action, this method can override to implement a custom functionality for right navbar button if needed
     */
    @objc public func navigationBarRightButtonCustomAction() {}

    /**
     A custom left navbar button action, this method can override to implement a custom functionality for left navbar button if needed
     */
    @objc public func navigationBarLeftButtonCustomAction() {}

    /**
     Methods can be overide in respective classes if needed.
     These are notification methods that will notify after navbar button actions.
     */
    @objc func navigationBarDismissed() {}
    @objc func navigationBarPoped() {}
}

// MARK: - Private Accessors

extension BaseViewController {
    /**
     Method to initialize and add activityindicator to base view
     */
    private func initializeNetworkActivityIndicator() {
        networkActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: Int(UIScreen.main.bounds.width)/2 - 15, y: Int(UIScreen.main.bounds.height)/2 - 15, width: 30, height: 30)
        )
        networkActivityIndicator?.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        DispatchQueue.main.async { [weak self] in
            if let activityView = self?.networkActivityIndicator {
                self?.view.addSubview(activityView)
            }
        }
    }

    /**
     Method to animate activityindicator based on flag value
     */
    fileprivate func networkActivityIndicatorStateChanged() {
        DispatchQueue.main.async { [weak self] in
            switch self?.animateNetworkActivityIndicator {
            case true:
                self?.networkActivityIndicator?.startAnimating()
            default:
                self?.networkActivityIndicator?.stopAnimating()
            }
        }
    }
}

extension BaseViewController {
    /**
     Method to initialize alertview
     */
    fileprivate func initializeAlertView(){
        alertController = UIAlertController(title: StringConstants.alert, message: "", preferredStyle: UIAlertController.Style.alert)
        alertController?.addAction(UIAlertAction(title: StringConstants.ok, style: UIAlertAction.Style.destructive, handler: nil))
    }
    
    /**
     Method to show alert
     */
    func showAlert(_ message: String) {
        alertController?.message = message
        if let controller = alertController {
            self.present(controller, animated: true, completion: nil)
        }
    }
}
