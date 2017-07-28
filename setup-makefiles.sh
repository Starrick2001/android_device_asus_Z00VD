#!/bin/bash

DEVICE=ASUS_Z00VD
VENDOR=asus

OUTDIR=vendor/$VENDOR/$DEVICE
MAKEFILE=../../../$OUTDIR/$DEVICE-vendor-blobs.mk

(cat << EOF) > $MAKEFILE
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

PRODUCT_COPY_FILES += \\
EOF
#ifeq (\$(MTKPATH),)
#PRODUCT_COPY_FILES += \\
#EOF

#LINEEND=" \\"
#FILES=$(eval echo `egrep -v '(^#|^$)' proprietary-files-mtk.txt`)
#COUNT=`echo $FILES | wc -w`
#
#for FILE in $FILES; do
#  COUNT=`expr $COUNT - 1`
#  if [ $COUNT = "0" ]; then
#    LINEEND=""
#  fi
#  # Split the file from the destination (format is "file[:destination]")
#  OLDIFS=$IFS IFS=":" PARSING_ARRAY=($FILE) IFS=$OLDIFS
#  if [[ ! "$FILE" =~ ^-.* ]]; then
#    FILE=`echo ${PARSING_ARRAY[0]} | sed -e "s/^-//g"`
#    DEST=${PARSING_ARRAY[1]}
#    if [ -n "$DEST" ]; then
#      FILE=$DEST
#    fi
#    echo "    $OUTDIR/proprietary/$FILE:system/$FILE$LINEEND" >> $MAKEFILE
#  fi
#done
#(cat << EOF) >> $MAKEFILE
#endif
#
#ifeq (\$(WITH_GMS),true)
#
#PRODUCT_COPY_FILES += \\
#   $OUTDIR/proprietary/etc/permissions/com.google.widevine.software.drm.xml:system/etc/permissions/com.google.widevine.software.drm.xml \\
#    $OUTDIR/proprietary/framework/com.google.widevine.software.drm.jar:system/framework/com.google.widevine.software.drm.jar
#
#endif # WITH_GMS
#
#PRODUCT_COPY_FILES += \\
#EOF

LINEEND=" \\"
FILES=$(eval echo `egrep -v '(^#|^$)' proprietary-files.txt`)
COUNT=`echo $FILES | wc -w`

for FILE in $FILES; do
  COUNT=`expr $COUNT - 1`
  if [ $COUNT = "0" ]; then
    LINEEND=""
  fi
  # Split the file from the destination (format is "file[:destination]")
  OLDIFS=$IFS IFS=":" PARSING_ARRAY=($FILE) IFS=$OLDIFS
  if [[ ! "$FILE" =~ ^-.* ]]; then
    FILE=`echo ${PARSING_ARRAY[0]} | sed -e "s/^-//g"`
    DEST=${PARSING_ARRAY[1]}
    if [ -n "$DEST" ]; then
      FILE=$DEST
    fi
    # Do not include files that not exists in *.mk to avoid errors [+] Decker
    CFILE=../../../$OUTDIR/proprietary/$FILE
    if [[ -f "$CFILE" ]]; then
    	echo "    $OUTDIR/proprietary/$FILE:system/$FILE$LINEEND" >> $MAKEFILE
    else
    	echo "    $OUTDIR/proprietary/$FILE - not found !"
    fi
  fi
done
(cat << EOF) >> $MAKEFILE
EOF

(cat << EOF) > ../../../$OUTDIR/$DEVICE-vendor.mk
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

# Pick up overlay for features that depend on non-open-source files
#PRODUCT_PACKAGES += \\
#    MTKLogger \
#    YGPS

# Proprietary dependencies go here

\$(call inherit-product, vendor/$VENDOR/$DEVICE/$DEVICE-vendor-blobs.mk)
EOF

(cat << EOF) > ../../../$OUTDIR/BoardConfigVendor.mk
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh
EOF

(cat << EOF) > ../../../$OUTDIR/Android.mk
# Copyright (C) 2016 The CyanogenMod Project
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

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

LOCAL_PATH := \$(call my-dir)

ifeq (\$(TARGET_DEVICE),porridge)
ifeq (\$(MTKPATH),)

# Proprietary Modules go here
#include \$(CLEAR_VARS)
#LOCAL_MODULE := MTKLogger
#LOCAL_MODULE_OWNER := $VENDOR
#LOCAL_SRC_FILES := proprietary/app/MTKLogger/MTKLogger.apk
#LOCAL_MODULE_TAGS := optional
#LOCAL_MODULE_SUFFIX := \$(COMMON_ANDROID_PACKAGE_SUFFIX)
#LOCAL_MODULE_CLASS := APPS
#LOCAL_CERTIFICATE := platform
#include \$(BUILD_PREBUILT)

#include \$(CLEAR_VARS)
#LOCAL_MODULE := YGPS
#LOCAL_MODULE_OWNER := $VENDOR
#LOCAL_SRC_FILES := proprietary/app/YGPS/YGPS.apk
#LOCAL_MODULE_TAGS := optional
#LOCAL_MODULE_SUFFIX := \$(COMMON_ANDROID_PACKAGE_SUFFIX)
#LOCAL_MODULE_CLASS := APPS
#LOCAL_CERTIFICATE := platform
#include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := libaudiopolicymanager
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_SRC_FILES_32 := proprietary/lib/libaudiopolicymanager.so
include \$(BUILD_PREBUILT)


endif
endif

include \$(call first-makefiles-under,\$(LOCAL_PATH))

EOF
