pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        mavenLocal()
    }
}

rootProject.name = "BesitosOfferwallSDK"

include(":besitos-offerwall")
include(":sample")

project(":besitos-offerwall").projectDir = file("besitos-offerwall")
project(":sample").projectDir = file("sample")
