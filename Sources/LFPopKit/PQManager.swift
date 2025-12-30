// The Swift Programming Language
// https://docs.swift.org/swift-book
import Combine

@MainActor
public final class PQManager {
    
    public typealias PopContent = any PQPopContentPro
    /// Shared singleton instance.
    public static let shared = PQManager()
    
    private var archiveQueque:[PopContent] = []
    /// Internal subject used to broadcast alert events.
    private let queque = PassthroughSubject<[PopContent], Never>()

    /// Public read-only publisher for alert events.
    public var publisher: AnyPublisher<[PopContent], Never> {
        queque.eraseToAnyPublisher()
    }
    
    //method
    
    /// Use this method to add a popView conformed to PWPopContentPro to the Queque
    public func addPopViewOnQueque(_ view:PopContent) {
        // when new value arrive its appended to the queque archive, and the archive is published
        self.archiveQueque.append(view)
        queque.send(self.archiveQueque)
    }
    
    /// use this method when dismiss a pop to remove it from the quque using id
    public func dismissPopFromQueque(id popId:String) {
        // when a pop is dismissed, its removed from the queque archive and the new archive is published
        self.archiveQueque.removeAll { $0.id == popId }
        queque.send(self.archiveQueque)
    }
    
}
