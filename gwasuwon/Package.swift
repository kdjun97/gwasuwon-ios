// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [:],
        baseSettings: .settings(
            configurations: [
                .debug(name: .dev),
                .debug(name: .prod),
                .release(name: .release)
            ]
        )
    )
#endif

let package = Package(
    name: "GwasuwonPackage",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.8.0"),
        .package(url: "https://github.com/johnpatrickmorgan/TCACoordinators.git", exact: "0.8.0"),
        .package(url: "https://github.com/johnpatrickmorgan/FlowStacks.git", exact: "0.4.0"),
        .package(url: "https://github.com/Swinject/Swinject.git", exact: "2.9.1"),
    ]
)
