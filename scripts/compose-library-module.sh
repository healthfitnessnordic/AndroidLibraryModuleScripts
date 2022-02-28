#!/bin/sh
cat > $1/build.gradle.kts << EOM
plugins {
    id("com.android.library")

    kotlin("android")
    kotlin("kapt")

    id("androidx.navigation.safeargs")
    id("dagger.hilt.android.plugin")
}

android {
    compileSdk = BuildValues.compileSdkVersion

    defaultConfig {
        minSdk = BuildValues.minSdkVersion
        targetSdk = BuildValues.targetSdkVersion

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildFeatures {
        compose = true
    }

    buildTypes {
        getByName(BuildTypes.debug)
        getByName(BuildTypes.release)
    }

    compileOptions {
        isCoreLibraryDesugaringEnabled = true

        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    composeOptions {
        kotlinCompilerExtensionVersion = libs.versions.jetpack.compose.get()
    }

    packagingOptions {
        resources.excludes.add("META-INF/AL2.0")
        resources.excludes.add("META-INF/LGPL2.1")
        resources.excludes.add("META-INF/licenses/ASM")
        resources.pickFirsts.add("win32-x86-64/attach_hotspot_windows.dll")
        resources.pickFirsts.add("win32-x86/attach_hotspot_windows.dll")
    }
}

dependencies {
    // Project modules

    // External Dependencies
    
    // Android
    coreLibraryDesugaring(libs.android.desugarJdkLibs)

    // AndroidX – Compose
    implementation(libs.bundles.jetpack.compose)

    androidTestImplementation(libs.jetpack.compose.ui.test)

    // AndroidX – Hilt
    implementation(libs.jetpack.hilt.navigation.compose)
    implementation(libs.jetpack.hilt.viewModel)
    kapt(libs.jetpack.hilt.compiler)

    // AndroidX – Lifecycle
    implementation(libs.jetpack.lifecycle.liveData)
    implementation(libs.jetpack.lifecycle.runtime)
    implementation(libs.jetpack.lifecycle.viewModel)

    // AndroidX – Test
    androidTestImplementation(libs.jetpack.test.junit)
    androidTestImplementation(libs.jetpack.test.espresso.core)

    // Dagger – Hilt
    implementation(libs.dagger.hilt.runtime)
    kapt(libs.dagger.hilt.compiler)

    testImplementation(libs.dagger.hilt.testing)
    kaptTest(libs.dagger.hilt.compiler)

    androidTestImplementation(libs.dagger.hilt.testing)
    kaptAndroidTest(libs.dagger.hilt.compiler)

    // JUnit
    testImplementation(libs.junit)

    // Kotlin
    implementation(libs.kotlin.stdLib)
}

EOM


cat > $1/src/main/AndroidManifest.xml << EOM
<?xml version="1.0" encoding="utf-8"?>
<manifest package="$2" />
EOM
