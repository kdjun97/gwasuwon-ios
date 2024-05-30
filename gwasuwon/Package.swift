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
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.5.0")
    ]
)
