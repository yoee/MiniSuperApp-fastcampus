import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener {
  var router: FinanceHomeRouting? { get set }
  var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
  func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {

  private let superPayDashboardBuildable: SuperPayDashboardBuildable
  private var superPayRouting: Routing?

  init(
    interactor: FinanceHomeInteractable,
    viewController: FinanceHomeViewControllable,
    superPayDashboardBuildable: SuperPayDashboardBuildable
  ) {
    self.superPayDashboardBuildable = superPayDashboardBuildable

    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  func attachSuperPayDashboard() {
    guard superPayRouting != nil else { return }

    let router = superPayDashboardBuildable.build(withListener: interactor)

    let dashboard = router.viewControllable
    viewController.addDashboard(dashboard)

    self.superPayRouting = router
    attachChild(router)
  }
}
