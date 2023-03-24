import UIKit
import SwiftUI
import SafariServices
import SwiftSoup

class ShareViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let inputItems = extensionContext?.inputItems as? [NSExtensionItem],
           let provider = inputItems.first?.attachments?.first,
           provider.hasItemConformingToTypeIdentifier("public.url") {
               
            provider.loadItem(forTypeIdentifier: "public.url", options: nil) { (url, error) in
                if let url = url as? URL {
                    self.getOpenGraphInfo(from: url) { (info) in
                        DispatchQueue.main.async {
                            let childView = UIHostingController(rootView: ShareView(model: info, shareController: self))
                            let screenHeight = UIScreen.main.bounds.height
                            let sheetHeight: CGFloat = screenHeight / 1.5
                            childView.view.frame = CGRect(x: 0, y: screenHeight - sheetHeight, width: UIScreen.main.bounds.width, height: sheetHeight)

                            self.addChild(childView)
                            self.view.addSubview(childView.view)
                            childView.didMove(toParent: self)
                            
                        }
                    }
                }
            }
        }
    }
    
    // Function to close the share sheet
    func close() {
        extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
    }

    // Function to dismiss the share sheet when the user taps the Cancel button
    @IBAction func cancelTapped() {
        close()
    }
    
    private func getOpenGraphInfo(from url: URL, completion: @escaping (OpenGraphInfo) -> Void) {
        guard let html = try? String(contentsOf: url) else {
            return
        }
        
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let metas: Elements = try doc.select("meta")
            
            var title: String?
            var description: String?
            var imageURL: URL?
            
            for meta in metas {
                let property = try meta.attr("property")
                if property == "og:title" {
                    title = try meta.attr("content")
                } else if property == "og:description" {
                    description = try meta.attr("content")
                } else if property == "og:image" {
                    let imageURLString = try meta.attr("content")
                    imageURL = URL(string: imageURLString)
                }
            }
            
            // Create OpenGraphInfo model and call completion handler
            let info = OpenGraphInfo(title: title, description: description, image: imageURL, url: url)
            completion(info)
            
        } catch {
            print(error)
        }
    }
}
