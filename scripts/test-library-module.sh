#!/bin/sh
cat > $1/build.gradle.kts << EOM
plugins {
    id("com.android.library")

    kotlin("android")
    kotlin("kapt")

    id("dagger.hilt.android.plugin")
}

android {
    compileSdk = BuildValues.compileSdkVersion

    defaultConfig {
        minSdk = BuildValues.minSdkVersion
        targetSdk = BuildValues.targetSdkVersion

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        getByName(BuildTypes.debug)
        getByName(BuildTypes.release)
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
}

dependencies {
    // Projects
    implementation(projects.booking.bookingData)
    implementation(projects.core.networking)
    implementation(projects.data.shared)
    implementation(projects.notifications.notificationsData)

    // AndroidX – Test
    implementation(libs.jetpack.test.core)
    implementation(libs.jetpack.test.junit)
    implementation(libs.jetpack.test.runner)

    // Arrow
    implementation(platform(libs.arrow.bom))
    implementation(libs.arrow.core)

    // Dagger – Hilt
    implementation(libs.dagger.hilt.runtime)
    implementation(libs.dagger.hilt.testing)
    kapt(libs.dagger.hilt.compiler)

    // JUnit
    implementation(libs.junit)

    // Kotlin
    implementation(libs.kotlin.stdLib)
}
EOM

cat > $1/src/main/AndroidManifest.xml << EOM
<?xml version="1.0" encoding="utf-8"?>
<manifest package="$2.testing" />
EOM
