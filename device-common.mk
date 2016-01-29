#
# Copyright (C) 2016 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This file includes all definitions that apply to ALL marlin and sailfish devices
#
# Everything in this directory will become public

# Enable support for chinook sensorhub
# TARGET_USES_CHINOOK_SENSORHUB := true

ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/htc/marlin-kernel/Image.gz-dtb
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif
TARGET_KERNEL_DLKM_DISABLE := true

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

DEVICE_PACKAGE_OVERLAYS := device/htc/marlin/overlay
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
BOARD_HAVE_QCOM_FM := false
TARGET_USES_NQ_NFC := false

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

# copy customized media_profiles and media_codecs xmls for msm8996
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/htc/marlin/media_profiles.xml:system/etc/media_profiles.xml \
                      device/htc/marlin/media_codecs.xml:system/etc/media_codecs.xml \
                      device/htc/marlin/media_codecs_performance.xml:system/etc/media_codecs_performance.xml
endif  #TARGET_ENABLE_QC_AV_ENHANCEMENTS

PRODUCT_COPY_FILES += device/htc/marlin/whitelistedapps.xml:system/etc/whitelistedapps.xml

# Override heap growth limit due to high display density on device
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapgrowthlimit=256m
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)
$(call inherit-product, device/htc/marlin/common/common64.mk)

#PRODUCT_NAME := msm8996
#PRODUCT_DEVICE := msm8996
#PRODUCT_BRAND := Android
#PRODUCT_MODEL := MSM8996 for arm64

# PRODUCT_BOOT_JARS += tcmiface

#ifneq ($(strip $(QCPATH)),)
#PRODUCT_BOOT_JARS += WfdCommon
#PRODUCT_BOOT_JARS += com.qti.dpmframework
#PRODUCT_BOOT_JARS += dpmapi
#PRODUCT_BOOT_JARS += com.qti.location.sdk
#endif

#ifeq ($(strip $(BOARD_HAVE_QCOM_FM)),true)
#PRODUCT_BOOT_JARS += qcom.fmradio
#endif #BOARD_HAVE_QCOM_FM
#PRODUCT_BOOT_JARS += qcmediaplayer

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

# Audio configuration file
ifeq ($(TARGET_USES_AOSP), true)
PRODUCT_COPY_FILES += \
    device/htc/marlin/common/media/audio_policy.conf:system/etc/audio_policy.conf
else
PRODUCT_COPY_FILES += \
    device/htc/marlin/audio_policy.conf:system/etc/audio_policy.conf
endif

PRODUCT_COPY_FILES += \
    device/htc/marlin/audio_output_policy.conf:system/vendor/etc/audio_output_policy.conf \
    device/htc/marlin/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/htc/marlin/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/htc/marlin/mixer_paths_tasha.xml:system/etc/mixer_paths_tasha.xml \
    device/htc/marlin/mixer_paths_dtp.xml:system/etc/mixer_paths_dtp.xml \
    device/htc/marlin/mixer_paths_i2s.xml:system/etc/mixer_paths_i2s.xml \
    device/htc/marlin/aanc_tuning_mixer.txt:system/etc/aanc_tuning_mixer.txt \
    device/htc/marlin/audio_platform_info_i2s.xml:system/etc/audio_platform_info_i2s.xml \
    device/htc/marlin/sound_trigger_mixer_paths.xml:system/etc/sound_trigger_mixer_paths.xml \
    device/htc/marlin/sound_trigger_mixer_paths_wcd9330.xml:system/etc/sound_trigger_mixer_paths_wcd9330.xml \
    device/htc/marlin/sound_trigger_platform_info.xml:system/etc/sound_trigger_platform_info.xml \
    device/htc/marlin/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    device/htc/marlin/AudioBTIDnew.csv:system/etc/AudioBTIDnew.csv \
    device/htc/marlin/Tfa98xx.cnt:system/etc/Tfa98xx.cnt \
    device/htc/marlin/Tfa98xx2.cnt:system/etc/Tfa98xx2.cnt \
    device/htc/marlin/Tfa98xx2_n1b.cnt:system/etc/Tfa98xx2_n1b.cnt \
    device/htc/marlin/Tfa98xx_n1b.cnt:system/etc/Tfa98xx_n1b.cnt \
    device/htc/marlin/htc_sound_mfg.txt:system/etc/htc_sound_mfg.txt

# WLAN driver configuration files
PRODUCT_COPY_FILES += \
    device/htc/marlin/WCNSS_cfg.dat:system/etc/firmware/wlan/qca_cld/WCNSS_cfg.dat \
    device/htc/marlin/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml

PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf

# Listen configuration file
PRODUCT_COPY_FILES += \
    device/htc/marlin/listen_platform_info.xml:system/etc/listen_platform_info.xml

#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app \
    libvolumelistener

# Sensor HAL conf file
PRODUCT_COPY_FILES += \
    device/htc/marlin/sensors/hals.conf:system/etc/sensors/hals.conf

# Sensor features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:system/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:system/etc/permissions/android.hardware.sensor.relative_humidity.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:system/etc/permissions/android.hardware.sensor.hifi_sensors.xml

# HTC_SENSOR_HUB
PRODUCT_COPY_FILES += \
    device/htc/marlin/i2ctest:system/bin/i2ctest \
    device/htc/marlin/libftm_lib_i2c_utility.so:system/lib64/libftm_lib_i2c_utility.so \
    device/htc/marlin/sensor_hub/sensor_hub_htc_xb.img:system/etc/firmware/sensor_hub_htc_xb.img
PRODUCT_PACKAGES += \
    downloadsensorhub

PRODUCT_SUPPORTS_VERITY := true
PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/bootdevice/by-name/system

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    device/htc/marlin/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf

ifeq ($(strip $(TARGET_USES_NQ_NFC)),true)
PRODUCT_PACKAGES += \
    NQNfcNci \
    libnqnfc-nci \
    libnqnfc_nci_jni \
    nfc_nci.nqx.default \
    libp61-jcop-kit \
    com.nxp.nfc.nq \
    com.nxp.nfc.nq.xml \
    libpn547_fw.so \
    libpn548ad_fw.so \
    libnfc-brcm.conf \
    libnfc-nxp.conf \
    nqnfcee_access.xml \
    nqnfcse_access.xml \
    Tag \
    com.android.nfc_extras \
    libQPayJNI \
    com.android.qti.qpay \
    com.android.qti.qpay.xml \
    SmartcardService \
    org.simalliance.openmobileapi \
    org.simalliance.openmobileapi.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml

# SmartcardService, SIM1,SIM2,eSE1 not including eSE2,SD1 as default
ADDITIONAL_BUILD_PROPERTIES += persist.nfc.smartcard.config=SIM1,SIM2,eSE1
endif # TARGET_USES_NQ_NFC

# Reduce client buffer size for fast audio output tracks
PRODUCT_PROPERTY_OVERRIDES += \
    af.fast_track_multiplier=1

# Low latency audio buffer size in frames
PRODUCT_PROPERTY_OVERRIDES += \
    audio_hal.period_size=192

PRODUCT_PROPERTY_OVERRIDES += \
    camera.disable_zsl_mode=1

PRODUCT_AAPT_CONFIG += xlarge large

# TODO: move to vendor mk file
### HTC touch ###
#PRODUCT_COPY_FILES += \
#    vendor/htc/marlin/prebuilts/tp_SYN3708.img:system/etc/firmware/synaptics.img

$(call inherit-product-if-exists, hardware/qcom/msm8996/msm8996.mk)
$(call inherit-product-if-exists, vendor/qcom/gpu/msm8996/msm8996-gpu-vendor.mk)

# TODO:
# setup dm-verity configs.
# PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/platform/soc/7464900.sdhci/by-name/system
# $(call inherit-product, build/target/product/verity.mk)
