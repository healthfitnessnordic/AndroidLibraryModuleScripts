#!/bin/sh
cat > $1/build.gradle.kts << EOM
plugins {
    id("com.android.library")

    kotlin("android")
    kotlin("kapt")

    kotlin("plugin.serialization")

    id("dagger.hilt.android.plugin")
}

android {
    compileSdk = BuildValues.compileSdkVersion

    defaultConfig {
        minSdk = BuildValues.minSdkVersion
        targetSdk = BuildValues.targetSdkVersion
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
}

dependencies {
    // Project modules
    
    // External Dependencies
    
    // Android
    coreLibraryDesugaring(libs.android.desugarJdkLibs)

    // Arrow
    api(platform(libs.arrow.bom))
    api(libs.arrow.core)

    // Dagger – Hilt
    implementation(libs.dagger.hilt.runtime)
    kapt(libs.dagger.hilt.compiler)

    // JUnit
    testImplementation(libs.junit)

    // Kotlin
    implementation(libs.kotlin.stdLib)

    // KotlinX – Coroutines
    implementation(libs.kotlinx.coroutines.core)
    testImplementation(libs.kotlinx.coroutines.test)

    // KotlinX – Serialization
    implementation(libs.kotlinx.serialization.json)

    // Ktor
    implementation(libs.ktor.core)
}

EOM

cat > $1/src/main/AndroidManifest.xml << EOM
<?xml version="1.0" encoding="utf-8"?>
<manifest package="$2.data" />
EOM
