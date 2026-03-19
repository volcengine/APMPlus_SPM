#!/bin/sh
################################################################################
# 自定义配置
###############################################################################
# Debug模式编译是否上传，1＝上传 0＝不上传，默认不上传
UPLOAD_DEBUG_SYMBOLS=0

# 模拟器编译是否上传，1＝上传，0＝不上传，默认不上传
UPLOAD_SIMULATOR_SYMBOLS=0

# APMPlusID：应用在APMPlus平台的ID
APMPlus_APP_ID="XXX"

# APMPlusUploadDSYMAPIKey：从平台的全部功能->符号表管理->系统选择 iOS->下面可以看到API Key。
APMPlus_Upload_DSYM_API_Key="XXX"

# APMPlusUploadDSYMAPIToken：从平台的全部功能->符号表管理->系统选择 iOS->下面可以看到API Token。
APMPlus_Upload_DSYM_API_Token="XXX"

# APMPlusUploadDomain：应用上报的域名，请在 [平台 - 应用接入iOS SDK](https://www.volcengine.com/docs/6431/68850#%E6%AD%A5%E9%AA%A4%E5%9B%9B%EF%BC%9A%E4%B8%8A%E4%BC%A0%E7%AC%A6%E5%8F%B7%E8%A1%A8) 查询映射表。
APMPlus_UPLOAD_DOMAIN="XXX"

# 上传通道开关：默认走 tos；如需使用旧链路则设置为 legacy
# - tos（默认）：/guest/app/mapping/check/tos -> TOS presigned_url PUT -> /guest/app/mapping/check/tos（确认触发符号化）
# - legacy：/guest/app/mapping/upload 直传
APMPLUS_UPLOAD_CHANNEL="tos"

################################################################################
# 注意: 如果你不知道此脚本的执行流程和用法，请不要随便修改！
################################################################################

APMPlus_DYSM_UPLOADER_VERSION='3.0'

DSYM_UPLOAD_PATH="/apmplus_api/eue/guest/app/mapping/upload"

if [[ $APMPlus_APP_ID == "XXX" ]]; then
    if [[ $1 ]]; then
        echo "APPID: $1"
        APMPlus_APP_ID=$1
    else
        echo "No arguments, pass your APMPlusID as the first argument or modify 'APMPlus_APP_ID' in the script."
        exit 1
    fi
fi

if [[ $APMPlus_Upload_DSYM_API_Key == "XXX" ]]; then
    if [[ $2 ]]; then
        echo "APMPlusUploadDSYMAPIKey: $2"
        APMPlus_Upload_DSYM_API_Key=$2
    else
        echo "No arguments, pass your APMPlusUploadDSYMAPIKey as the second argument or modify 'APMPlus_Upload_DSYM_API_Key' in the script."
        exit 1
    fi
fi

if [[ $APMPlus_Upload_DSYM_API_Token == "XXX" ]]; then
    if [[ $3 ]]; then
        echo "APMPlusUploadDSYMAPIToken: $3"
        APMPlus_Upload_DSYM_API_Token=$3
    else
        echo "No arguments, pass your APMPlusUploadDSYMAPIToken as the third argument or modify 'APMPlus_Upload_DSYM_API_Token' in the script."
        exit 1
    fi
fi

if [[ $APMPlus_UPLOAD_DOMAIN == "XXX" ]]; then
    if [[ $4 ]]; then
        APMPlus_UPLOAD_DOMAIN=$4
        if [[ $APMPlus_UPLOAD_DOMAIN != http://* && $APMPlus_UPLOAD_DOMAIN != https://* ]]; then
            APMPlus_UPLOAD_DOMAIN="https://${APMPlus_UPLOAD_DOMAIN}"
        fi
        if [[ $APMPlus_UPLOAD_DOMAIN =~ /$ ]]; then
            APMPlus_UPLOAD_DOMAIN=${APMPlus_UPLOAD_DOMAIN%/*}
        fi
        echo "Upload domain: $APMPlus_UPLOAD_DOMAIN"
    else
        echo "No arguments, pass your APMPlusUploadDomain as the fourth argument of modify 'APMPlus_UPLOAD_DOMAIN' in the script."
        exit 1
    fi
fi

DSYM_UPLOAD_URL="${APMPlus_UPLOAD_DOMAIN}${DSYM_UPLOAD_PATH}"
DSYM_CHECK_TOS_PATH="/apmplus_api/eue/guest/app/mapping/check/tos"
DSYM_CHECK_TOS_URL="${APMPlus_UPLOAD_DOMAIN}${DSYM_CHECK_TOS_PATH}"

function main() {
    # 退出执行并打印提示信息
    warningWithMessage() {
        echo "--------------------------------"
        echo -e "${1}"
        echo "--------------------------------"
        echo "No upload and over."
        echo "----------------------------------------------------------------"
        UPLOADFLAG=0
        exit ${2}
    }
    
    UPLOADFLAG=1
    
    echo "Uploading dSYM to APMPlus."
    
    echo "--------------------------------"
    echo "Step 1: Prepare application information."
    echo "--------------------------------"
    
    echo "Product Name: ${PRODUCT_NAME}"
    echo "APMPlus upload domain: ${APMPlus_UPLOAD_DOMAIN}"
    echo "APMPlus upload URL: ${DSYM_UPLOAD_URL}"
    
    echo "--------------------------------"
    echo "Step 2: Check the arguments ..."
    echo "--------------------------------"
    
    ##检查模拟器是否允许上传符号
    if [ "$EFFECTIVE_PLATFORM_NAME" == "-iphonesimulator" ]; then
        if [[ $UPLOAD_SIMULATOR_SYMBOLS -eq 0 ]]; then
            warningWithMessage "Warning: Build for simulator and skipping to upload. \nYou can modify 'UPLOAD_SIMULATOR_SYMBOLS' to 1 in the script." 0
        fi
    fi
    
    # 检查DEBUG模式是否允许上传符号
    if [[ ${CONFIGURATION=} == Debug* ]]; then
        if [[ $UPLOAD_DEBUG_SYMBOLS -eq 0 ]]; then
            warningWithMessage "Warning: Build for debug mode and skipping to upload. \nYou can modify 'UPLOAD_DEBUG_SYMBOLS' to 1 in the script." 0
        fi
    fi
    
    # 检查必须参数是否设置
    if [ ! "${APMPlus_APP_ID}" ]; then
        warningWithMessage "Error: APMPlus App ID not defined." 1
    fi
    
    if [ ! "${APMPlus_Upload_DSYM_API_Key}" ]; then
        warningWithMessage "Error: APMPlus upload API Key not defined." 1
    fi
    
    if [ ! "${APMPlus_Upload_DSYM_API_Token}" ]; then
        warningWithMessage "Error: APMPlus upload API Token not defined." 1
    fi
    
    # 检查上报域名是否设置
    if [ ! "${APMPlus_UPLOAD_DOMAIN}" ]; then
        warningWithMessage "Error: APMPlus upload domain not defined." 1
    fi

    jsonGetNumberValue() {
        echo "${1}" | sed -n "s/.*\"${2}\"[[:space:]]*:[[:space:]]*\([0-9][0-9]*\).*/\1/p" | head -n 1
    }

    jsonGetStringValue() {
        echo "${1}" | sed -n "s/.*\"${2}\"[[:space:]]*:[[:space:]]*\"\([^\"]*\)\".*/\1/p" | head -n 1
    }

    generateOpenAPISignature() {
        CURRENT_TIMESTAMP=$(date "+%s")000

        MD5RESULT=$(md5 -s "${CURRENT_TIMESTAMP}${APMPlus_Upload_DSYM_API_Token}")
        RESULTPARTS=($MD5RESULT)
        SIGNATURE=""
        for part in "${RESULTPARTS[@]}"; do
            if [[ ${#part} -eq 32 && $part =~ ^[0-9a-fA-F]+$ ]]; then
                SIGNATURE="$part"
                break
            fi
        done

        if [ "${SIGNATURE}" = "" ]; then
            warningWithMessage "Error: Failed to generate md5." 1
        fi
    }

    postCheckTos() {
        CHECK_TOS_HTTP_CODE=""
        CHECK_TOS_BODY=""
        CHECK_TOS_ERROR_NO=""
        CHECK_TOS_ERROR_MSG=""
        CHECK_TOS_STAGE_CODE=""
        CHECK_TOS_STAGE_DESC=""
        CHECK_TOS_PRESIGNED_URL=""

        local zip_md5="${1}"
        local file_size="${2}"
        local meta_md5="${3}"
        local file_name="${4}"

        local resp
        echo "curl -sS -w \"\\n%{http_code}\" -X POST \"${DSYM_CHECK_TOS_URL}\" -F \"meta_md5=${meta_md5}\" -F \"file_size=${file_size}\" -F \"type=Dwarf\" -F \"os=iOS\" -F \"aid=${APMPlus_APP_ID}\" -F \"md5=${zip_md5}\" -F \"file_name=${file_name}\" -H \"Content-Type: multipart/form-data\" -H \"X-OpenApi-Timestamp: ${CURRENT_TIMESTAMP}\" -H \"X-OpenApi-AppID: ${APMPlus_Upload_DSYM_API_Key}\" -H \"X-OpenApi-Token: ${SIGNATURE}\" -H \"x-app-ids: ${APMPlus_APP_ID}\""
        resp=$(curl -sS -w "\n%{http_code}" -X POST "${DSYM_CHECK_TOS_URL}" \
            -F "meta_md5=${meta_md5}" \
            -F "file_size=${file_size}" \
            -F "type=Dwarf" \
            -F "os=iOS" \
            -F "aid=${APMPlus_APP_ID}" \
            -F "md5=${zip_md5}" \
            -F "file_name=${file_name}" \
            -H "Content-Type: multipart/form-data" \
            -H "X-OpenApi-Timestamp: ${CURRENT_TIMESTAMP}" \
            -H "X-OpenApi-AppID: ${APMPlus_Upload_DSYM_API_Key}" \
            -H "X-OpenApi-Token: ${SIGNATURE}" \
            -H "x-app-ids: ${APMPlus_APP_ID}")

        CHECK_TOS_HTTP_CODE=$(echo "${resp}" | tail -n 1)
        CHECK_TOS_BODY=$(echo "${resp}" | sed '$d')

        local json
        json=$(echo "${CHECK_TOS_BODY}" | tr -d '\n\r')
        CHECK_TOS_ERROR_NO=$(jsonGetNumberValue "${json}" "error_no")
        CHECK_TOS_ERROR_MSG=$(jsonGetStringValue "${json}" "error_msg")
        CHECK_TOS_STAGE_CODE=$(jsonGetNumberValue "${json}" "stage_code")
        CHECK_TOS_STAGE_DESC=$(jsonGetStringValue "${json}" "stage_desc")
        CHECK_TOS_PRESIGNED_URL=$(jsonGetStringValue "${json}" "presigned_url")
    }

    postLegacyUpload() {
        LEGACY_HTTP_CODE=""
        LEGACY_BODY=""
        LEGACY_ERROR_NO=""
        LEGACY_ERROR_MSG=""

        local file_path="${1}"

        local resp
        echo "curl -sS -w \"\\n%{http_code}\" -X POST \"${DSYM_UPLOAD_URL}\" -F \"file=@${file_path}\" -F \"type=Dwarf\" -F \"os=iOS\" -F \"aid=${APMPlus_APP_ID}\" -F \"script-version=${APMPlus_DYSM_UPLOADER_VERSION}\" -H \"Content-Type: multipart/form-data\" -H \"X-OpenApi-Timestamp: ${CURRENT_TIMESTAMP}\" -H \"X-OpenApi-AppID: ${APMPlus_Upload_DSYM_API_Key}\" -H \"X-OpenApi-Token: ${SIGNATURE}\" -H \"x-app-ids: ${APMPlus_APP_ID}\""
        resp=$(curl -sS -w "\n%{http_code}" -X POST "${DSYM_UPLOAD_URL}" \
            -F "file=@${file_path}" \
            -F "type=Dwarf" \
            -F "os=iOS" \
            -F "aid=${APMPlus_APP_ID}" \
            -F "script-version=${APMPlus_DYSM_UPLOADER_VERSION}" \
            -H "Content-Type: multipart/form-data" \
            -H "X-OpenApi-Timestamp: ${CURRENT_TIMESTAMP}" \
            -H "X-OpenApi-AppID: ${APMPlus_Upload_DSYM_API_Key}" \
            -H "X-OpenApi-Token: ${SIGNATURE}" \
            -H "x-app-ids: ${APMPlus_APP_ID}")

        LEGACY_HTTP_CODE=$(echo "${resp}" | tail -n 1)
        LEGACY_BODY=$(echo "${resp}" | sed '$d')

        local json
        json=$(echo "${LEGACY_BODY}" | tr -d '\n\r')
        LEGACY_ERROR_NO=$(jsonGetNumberValue "${json}" "error_no")
        LEGACY_ERROR_MSG=$(jsonGetStringValue "${json}" "error_msg")
    }

    tosPutUpload() {
        TOS_PUT_HTTP_CODE=""
        local upload_url="${1}"
        local file_path="${2}"

        echo "curl -sS -o /dev/null -w \"%{http_code}\" -X PUT --retry 3 --retry-all-errors --retry-delay 1 --connect-timeout 10 -H \"Content-Type: binary/octet-stream\" -T \"${file_path}\" \"${upload_url}\""
        TOS_PUT_HTTP_CODE=$(curl -sS -o /dev/null -w "%{http_code}" -X PUT \
            --retry 3 \
            --retry-all-errors \
            --retry-delay 1 \
            --connect-timeout 10 \
            -H "Content-Type: binary/octet-stream" \
            -T "${file_path}" \
            "${upload_url}")
    }
    
    function uploadDSYM() {
        DSYM_SRC="$1"
        if [ ! -d "$DSYM_SRC" ]; then
            warningWithMessage "dSYM source not found: ${DSYM_SRC}" 1
        fi

        ZIP_DIR_PATH=$(dirname "${DSYM_SRC}")
        DSYM_BUNDLE_NAME=$(basename "${DSYM_SRC}")

        DWARF_DIR="${DSYM_SRC}/Contents/Resources/DWARF"
        DWARF_FILES=$(find "${DWARF_DIR}" -type f)
        if [ "${DWARF_FILES}" = "" ]; then
            warningWithMessage "Error: No DWARF file found under ${DWARF_DIR}" 1
        fi

        DWARF_COUNT=$(echo "${DWARF_FILES}" | wc -l | tr -d ' ')
        echo "DWARF file count: ${DWARF_COUNT}"

        OLDIFS="${IFS}"
        IFS=$'\n'
        for DWARF_FPATH in ${DWARF_FILES}; do
            DWARF_BASE=$(basename "${DWARF_FPATH}")

            if [ "${DWARF_COUNT}" -gt 1 ]; then
                echo "Found multiple Mach-O files in DWARF, split upload enabled."
                DSYM_SYMBOL_OUT_ZIP_NAME="${PRODUCT_NAME}.app.${DWARF_BASE}.dSYM.zip"
            else
                DSYM_SYMBOL_OUT_ZIP_NAME="${PRODUCT_NAME}.app.dSYM.zip"
            fi

            DSYM_ZIP_FPATH="${ZIP_DIR_PATH}/${DSYM_SYMBOL_OUT_ZIP_NAME}"
            DSYM_ZIP_FILE_NAME=$(basename "${DSYM_ZIP_FPATH}")

            echo "--------------------------------"
            echo "Uploading for DWARF: ${DWARF_BASE}"
            echo "--------------------------------"

            SPLIT_PARENT=$(mktemp -d -t apmplus_dsym_uploader)
            if [ ! -d "${SPLIT_PARENT}" ]; then
                warningWithMessage "Error: Failed to create temp directory." 1
            fi

            cp -R "${DSYM_SRC}" "${SPLIT_PARENT}/"
            SPLIT_DSYM_PATH="${SPLIT_PARENT}/${DSYM_BUNDLE_NAME}"
            SPLIT_DWARF_DIR="${SPLIT_DSYM_PATH}/Contents/Resources/DWARF"
            find "${SPLIT_DWARF_DIR}" -type f ! -name "${DWARF_BASE}" -delete

            SELECTED_DWARF_FPATH="${SPLIT_DWARF_DIR}/${DWARF_BASE}"
            if [ ! -s "${SELECTED_DWARF_FPATH}" ]; then
                warningWithMessage "Error: Failed to locate DWARF file after split: ${SELECTED_DWARF_FPATH}" 1
            fi

            if [ -f "${DSYM_ZIP_FPATH}" ]; then
                rm "${DSYM_ZIP_FPATH}"
            fi

            cd "${SPLIT_PARENT}"
            PAD=$(zip -r "${DSYM_ZIP_FPATH}" "${DSYM_BUNDLE_NAME}")

            if [ ! -s "${DSYM_ZIP_FPATH}" ]; then
                warningWithMessage "no dSYM zip archive generated: ${DSYM_ZIP_FPATH}" 1
            fi

            case "${DSYM_ZIP_FPATH}" in
                *.zip)
                ;;
                *)
                    warningWithMessage "Error: The upload file is not a .zip file: ${DSYM_ZIP_FPATH}" 1
                ;;
            esac

            FILESIZE=$(/usr/bin/stat -f%z "${DSYM_ZIP_FPATH}")
            echo "dsym size: ${FILESIZE} bytes"

            echo "--------------------------------"
            echo "Step 3: Upload the zipped dSYM file."
            echo "--------------------------------"

            MD5ZIP=$(md5 -q "${DSYM_ZIP_FPATH}")
            if [ ! ${#MD5ZIP} -eq 32 ]; then
                warningWithMessage "Error: Failed to caculate md5 of zipped file." 1
            fi
            echo "zip md5 : ${MD5ZIP}"

            META_MD5=$(md5 -q "${SELECTED_DWARF_FPATH}")
            if [ ! ${#META_MD5} -eq 32 ]; then
                warningWithMessage "Error: Failed to caculate meta_md5 of DWARF file: ${SELECTED_DWARF_FPATH}" 1
            fi
            echo "meta md5 : ${META_MD5} (${SELECTED_DWARF_FPATH})"

            echo "dSYM upload url: ${DSYM_UPLOAD_URL}"

            if [ "${APMPLUS_UPLOAD_CHANNEL}" = "legacy" ]; then
                echo "--------------------------------"
                echo "Step 4: Upload dSYM by legacy channel."
                echo "--------------------------------"

                generateOpenAPISignature
                echo "current timestamp : ${CURRENT_TIMESTAMP}"

                postLegacyUpload "${DSYM_ZIP_FPATH}"
                echo "legacy http code: ${LEGACY_HTTP_CODE}"
                echo "legacy response: ${LEGACY_BODY}"

                if [[ ${LEGACY_HTTP_CODE} != 2* ]]; then
                    warningWithMessage "Error: legacy upload request failed. http_code=${LEGACY_HTTP_CODE}\n${LEGACY_BODY}" 1
                fi

                if [ "${LEGACY_ERROR_NO}" != "0" ]; then
                    warningWithMessage "Error: legacy upload error_no=${LEGACY_ERROR_NO} error_msg=${LEGACY_ERROR_MSG}\n${LEGACY_BODY}" 1
                fi

                echo "Upload dSYM successfully! Delete ${DSYM_ZIP_FPATH}."
                if [ -f "${DSYM_ZIP_FPATH}" ]; then
                    rm "${DSYM_ZIP_FPATH}"
                fi

                rm -rf "${SPLIT_PARENT}"
                continue
            fi

            generateOpenAPISignature
            echo "current timestamp : ${CURRENT_TIMESTAMP}"
            echo "check/tos url: ${DSYM_CHECK_TOS_URL}"

            echo "--------------------------------"
            echo "Step 4: Request presigned upload url."
            echo "--------------------------------"

            postCheckTos "${MD5ZIP}" "${FILESIZE}" "${META_MD5}" "${DSYM_ZIP_FILE_NAME}"
            echo "check/tos http code: ${CHECK_TOS_HTTP_CODE}"
            echo "check/tos response: ${CHECK_TOS_BODY}"

            if [[ ${CHECK_TOS_HTTP_CODE} != 2* ]]; then
                warningWithMessage "Error: check/tos request failed. http_code=${CHECK_TOS_HTTP_CODE}\n${CHECK_TOS_BODY}" 1
            fi

            if [ "${CHECK_TOS_ERROR_NO}" != "0" ]; then
                warningWithMessage "Error: check/tos error_no=${CHECK_TOS_ERROR_NO} error_msg=${CHECK_TOS_ERROR_MSG}\n${CHECK_TOS_BODY}" 1
            fi

            if [ "${CHECK_TOS_STAGE_CODE}" = "0" ]; then
                echo "No need to upload: ${CHECK_TOS_STAGE_DESC}"
                echo "Upload dSYM successfully! Delete ${DSYM_ZIP_FPATH}."
                if [ -f "${DSYM_ZIP_FPATH}" ]; then
                    rm "${DSYM_ZIP_FPATH}"
                fi

                rm -rf "${SPLIT_PARENT}"
                continue
            fi

            if [ "${CHECK_TOS_STAGE_CODE}" != "1" ]; then
                warningWithMessage "Error: Unexpected stage_code from check/tos: ${CHECK_TOS_STAGE_CODE}\n${CHECK_TOS_BODY}" 1
            fi

            if [ "${CHECK_TOS_PRESIGNED_URL}" = "" ]; then
                warningWithMessage "Error: check/tos returned empty presigned_url.\n${CHECK_TOS_BODY}" 1
            fi

            echo "--------------------------------"
            echo "Step 5: Upload file to TOS by presigned url."
            echo "--------------------------------"

            tosPutUpload "${CHECK_TOS_PRESIGNED_URL}" "${DSYM_ZIP_FPATH}"
            echo "tos put http code: ${TOS_PUT_HTTP_CODE}"

            if [[ ${TOS_PUT_HTTP_CODE} != 2* ]]; then
                warningWithMessage "Error: Failed to upload file to TOS. http_code=${TOS_PUT_HTTP_CODE}" 1
            fi

            echo "--------------------------------"
            echo "Step 6: Confirm upload to trigger symbolization."
            echo "--------------------------------"

            generateOpenAPISignature
            postCheckTos "${MD5ZIP}" "${FILESIZE}" "${META_MD5}" "${DSYM_ZIP_FILE_NAME}"
            echo "confirm http code: ${CHECK_TOS_HTTP_CODE}"
            echo "confirm response: ${CHECK_TOS_BODY}"

            if [[ ${CHECK_TOS_HTTP_CODE} != 2* ]]; then
                warningWithMessage "Error: confirm request failed. http_code=${CHECK_TOS_HTTP_CODE}\n${CHECK_TOS_BODY}" 1
            fi

            if [ "${CHECK_TOS_ERROR_NO}" != "0" ]; then
                warningWithMessage "Error: confirm error_no=${CHECK_TOS_ERROR_NO} error_msg=${CHECK_TOS_ERROR_MSG}\n${CHECK_TOS_BODY}" 1
            fi

            if [ "${CHECK_TOS_STAGE_CODE}" != "0" ]; then
                warningWithMessage "Error: Unexpected stage_code after confirm: ${CHECK_TOS_STAGE_CODE}\n${CHECK_TOS_BODY}" 1
            fi

            echo "Upload dSYM successfully! Delete ${DSYM_ZIP_FPATH}."
            if [ -f "${DSYM_ZIP_FPATH}" ]; then
                rm "${DSYM_ZIP_FPATH}"
            fi

            rm -rf "${SPLIT_PARENT}"
        done
        IFS="${OLDIFS}"
    }
        
    # .dSYM文件信息
    echo "DSYM FOLDER ${DWARF_DSYM_FOLDER_PATH}"
    
    DSYM_FOLDER="${DWARF_DSYM_FOLDER_PATH}"
    
    FOUND_DSYM=0
    for i in {1..100};
    do
        sleep 1

        if [ $((i % 10)) -eq 0 ]; then
            echo "Waiting for dSYM generated... (${i}s)"
        fi

        # 遍历目录查找当前工程名的文件
        for dsymFile in $(find "$DSYM_FOLDER" -name "${PRODUCT_NAME}.*.dSYM");
        do
            if [ ${UPLOADFLAG} -eq 1 ]; then
                DWARF_DIR="${dsymFile}/Contents/Resources/DWARF"
                DWARF_ONE_FILE=$(find "${DWARF_DIR}" -type f | head -n 1)
                if [ "${DWARF_ONE_FILE}" != "" ] && [ -s "${DWARF_ONE_FILE}" ]; then
                    echo "Found dSYM file: $dsymFile"
                    uploadDSYM "${dsymFile}"
                    FOUND_DSYM=1
                    break 2
                fi
            fi
        done
    done

    if [ ${FOUND_DSYM} -eq 0 ]; then
        warningWithMessage "Warning: No dSYM file found under ${DSYM_FOLDER} for ${PRODUCT_NAME} after waiting 100s.\nSkip uploading." 0
    fi
}
    
main
