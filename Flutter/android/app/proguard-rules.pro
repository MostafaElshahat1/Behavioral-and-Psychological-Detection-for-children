# Keep Stripe pushProvisioning classes used by react-native-stripe SDK
-keep class com.stripe.android.pushProvisioning.** { *; }
-dontwarn com.stripe.android.pushProvisioning.**

# Also keep reactnativestripesdk pushprovisioning bridge classes
-keep class com.reactnativestripesdk.pushprovisioning.** { *; }
-dontwarn com.reactnativestripesdk.pushprovisioning.**

# If other Stripe classes are removed incorrectly, keep the main package
-keep class com.stripe.** { *; }
-dontwarn com.stripe.**
