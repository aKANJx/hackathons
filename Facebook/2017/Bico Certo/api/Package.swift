import PackageDescription

let package = Package(
    name: "BicoCerto",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 4),
        .Package(url: "https://github.com/vapor/postgresql-provider", majorVersion: 1, minor: 1)
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests",
    ]
)

