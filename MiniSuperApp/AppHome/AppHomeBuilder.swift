import ModernRIBs

public protocol AppHomeDependency: Dependency {
}

final class AppHomeComponent: Component<AppHomeDependency>, TransportHomeDependency {
}

// MARK: - Builder

// 리블렛 객체 생성
public protocol AppHomeBuildable: Buildable {
  func build(withListener listener: AppHomeListener) -> ViewableRouting
}

public final class AppHomeBuilder: Builder<AppHomeDependency>, AppHomeBuildable {

    // 디펜던시 받음
  public override init(dependency: AppHomeDependency) {
    super.init(dependency: dependency)
  }

    // 빌드. 리블렛에 필요한 객체 생성
  public func build(withListener listener: AppHomeListener) -> ViewableRouting {
    let component = AppHomeComponent(dependency: dependency) // 로직 추가 될 때, 로직이 수행되는데 필요한 객체 담고 있을 바구니
    let viewController = AppHomeViewController()
    let interactor = AppHomeInteractor(presenter: viewController) // 비지니스 로직이 들어갈 두뇌
    interactor.listener = listener
    
    let transportHomeBuilder = TransportHomeBuilder(dependency: component)
    
    return AppHomeRouter( // 리블렛 간의 이동 담당.
      interactor: interactor,
      viewController: viewController,
      transportHomeBuildable: transportHomeBuilder
    )
  }
}
