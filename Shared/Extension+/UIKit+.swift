import UIKit

extension UIView: FactoryType {}
extension UIView: FactoryIdentifier {}

public protocol FactoryNib {
  static var nib: UINib {get}
}

extension FactoryNib where Self: UIView {
  public static var nib: UINib {
    return UINib(nibName: String(describing: Self.self), bundle: nil)
  }
}

extension UIView: FactoryNib {}

public protocol FactoryUIView {
  static func fromNib() -> Self
}

public extension FactoryUIView where Self: UIView {
  static func fromNib() -> Self {
    let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: nil, options: nil)!.first as! Self
    return view
  }
}

extension UIView: FactoryUIView {}

public protocol FactoryUIViewController {
  static func fromNib() -> Self
  static func fromStoryboard(name: String) -> Self
}

public extension FactoryUIViewController where Self: UIViewController {

  static func fromNib() -> Self {
    return .init(nibName: String(describing: Self.self), bundle: nil)
  }

  static func fromStoryboard(name: String) -> Self {
    let storyboard = UIStoryboard(name: name, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as! Self
    return viewController
  }
}

extension UIViewController: FactoryUIViewController {}


//MARK: UICollectionView
public extension UICollectionView {

  func register<T: UICollectionViewCell>(nib type: T.Type) {
    register(type.nib, forCellWithReuseIdentifier: type.identifier)
  }

  func register<T: UICollectionViewCell>(class type: T.Type) {
    register(type, forCellWithReuseIdentifier: type.identifier)
  }

  func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T {
    return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as! T
  }

}

//MARK: UITableView
public extension UITableView {

  func register<T: UITableViewCell>(nib type: T.Type) {
    register(type.nib, forCellReuseIdentifier: type.identifier)
  }

  func register<T: UITableViewCell>(class type: T.Type) {
    register(type, forCellReuseIdentifier: type.identifier)
  }

  func registerHeaderFooterView<T: UIView>(nib type: T.Type) {
    register(type.nib, forHeaderFooterViewReuseIdentifier: type.identifier)
  }

  func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T {
    return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! T
  }

  func dequeueReusableCellHeaderFooterView<T: UIView>(_ type: T.Type) -> T {
    return dequeueReusableHeaderFooterView(withIdentifier: type.identifier) as! T
  }

}

class ClosureHandler {
    let closure: (_:AnyObject?) -> Void
    let target: AnyObject?
    init(
        target: AnyObject?,
        closure: @escaping ( _ target: AnyObject?) -> Void   /// swift 2.3 closure use @escaping as default
        ) {
        self.closure = closure
        self.target = target
        objc_setAssociatedObject(
            target as Any,
            String(format: "[%d]", arc4random()),
            self,
            objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
        )
    }

    @objc func invoke () {
        closure(target)
    }
}

extension UIControl {
    func addAction(_ controlEvents: UIControl.Event,
                   closure: @escaping ( _ target: AnyObject?) -> Void) {

        let handler = ClosureHandler(
            target: self,
            closure: closure
        )
        addTarget(
            handler,
            action: #selector(ClosureHandler.invoke),
            for: controlEvents
        )
    }
}

import MessageUI

final class SendEmailService: NSObject, MFMailComposeViewControllerDelegate {
  
  func sendEmail(_ vc: UIViewController?) {
    if MFMailComposeViewController.canSendMail() {
      let mail = MFMailComposeViewController()
      mail.mailComposeDelegate = self
      mail.setToRecipients(["nguyenphong.mobile.engineer@gmail.com"])
      mail.setMessageBody("", isHTML: true)
      vc?.present(mail, animated: true)
    } else {
      let email = "nguyenphong.mobile.engineer@gmail.com"
      if let url = URL(string: "mailto:\(email)") {
        if #available(iOS 10.0, *) {
          UIApplication.shared.open(url)
        } else {
          UIApplication.shared.openURL(url)
        }
      }
    }
  }
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
  }

}

#if os(iOS)

import UIKit
extension UIApplication {
     func dismissKeyboard() {
         sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
 }

#endif
