LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_CLANG := true

LOCAL_MODULE                    := libexsurfaceflinger
LOCAL_MODULE_TAGS               := optional
LOCAL_MODULE_OWNER              := qti

LOCAL_PROPRIETARY_MODULE        := false
LOCAL_CFLAGS                    := -DLOG_TAG=\"ExSurfaceFlinger\"
LOCAL_CFLAGS                    += -DHAS_CONTEXT_PRIORITY

LOCAL_C_INCLUDES                += $(TARGET_OUT_HEADERS)
LOCAL_C_INCLUDES                += frameworks/native-caf/services/surfaceflinger
ifneq ($(TARGET_QCOM_DISPLAY_VARIANT),)
    LOCAL_C_INCLUDES        += hardware/qcom/display-$(TARGET_QCOM_DISPLAY_VARIANT)/libgralloc
    LOCAL_C_INCLUDES        += hardware/qcom/display-$(TARGET_QCOM_DISPLAY_VARIANT)/libqdutils
else
    LOCAL_C_INCLUDES += hardware/qcom/display/libgralloc
    LOCAL_C_INCLUDES += hardware/qcom/display/libqdutils
endif

LOCAL_SHARED_LIBRARIES          := libsurfaceflinger libui libgui \
                                   libbinder libutils libcutils \
                                   libandroid

ifeq ($(TARGET_USES_QCOM_BSP),true)
    LOCAL_CFLAGS                += -DQTI_BSP
    LOCAL_SHARED_LIBRARIES      += libqdutils
endif

LOCAL_SRC_FILES                 := ExLayer.cpp \
                                   ExSurfaceFlinger.cpp \
                                   DisplayHardware/ExVirtualDisplaySurface.cpp \
                                   DisplayHardware/ExHWComposer.cpp

include $(BUILD_STATIC_LIBRARY)
