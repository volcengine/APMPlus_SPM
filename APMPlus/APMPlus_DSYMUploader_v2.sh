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

# APMPlusToken: 应用在APMPlus平台的Token
APMPlus_APP_Token="XXX"

# APMPlusUploadDomain：应用上报的域名，请在 [平台 - 应用接入iOS SDK](https://www.volcengine.com/docs/6431/68850#%E6%AD%A5%E9%AA%A4%E5%9B%9B%EF%BC%9A%E4%B8%8A%E4%BC%A0%E7%AC%A6%E5%8F%B7%E8%A1%A8) 查询映射表。
APMPlus_UPLOAD_DOMAIN="XXX"

################################################################################
# 注意: 如果你不知道此脚本的执行流程和用法，请不要随便修改！
################################################################################

APMPlus_DYSM_UPLOADER_VERSION='2.0'

DSYM_UPLOAD_PATH="/apmplus_api/eue/guest/app/mapping/upload"

if [[ $APMPlus_APP_ID == "XXX" ]]; then
    if [[ $1 ]]; then
        echo "APPID: $1"
        APMPlus_APP_ID=$1
    else
        echo "No arguments, pass your APMPlusID as the first argument or modify 'APMPlus_APP_ID' in the script."
        exit 0
    fi
fi

if [[ $APMPlus_APP_Token == "XXX" ]]; then
    if [[ $2 ]]; then
        echo "APPToken: $2"
        APMPlus_APP_Token=$2
    else
        echo "No arguments, pass your APMPlusID as the second argument or modify 'APMPlus_APP_Token' in the script."
        exit 0
    fi
fi

if [[ $APMPlus_UPLOAD_DOMAIN == "XXX" ]]; then
    if [[ $3 ]]; then
        APMPlus_UPLOAD_DOMAIN=$3
        if [[ $APMPlus_UPLOAD_DOMAIN != http://* && $APMPlus_UPLOAD_DOMAIN != https://* ]]; then
            APMPlus_UPLOAD_DOMAIN="https://${APMPlus_UPLOAD_DOMAIN}"
        fi
        if [[ $APMPlus_UPLOAD_DOMAIN =~ /$ ]]; then
            APMPlus_UPLOAD_DOMAIN=${APMPlus_UPLOAD_DOMAIN%/*}
        fi
        echo "Upload domain: $APMPlus_UPLOAD_DOMAIN"
    else
        echo "No arguments, pass your APMPlusUploadDomain as the third argument of modify 'APMPlus_UPLOAD_DOMAIN' in the script."
        exit 0
    fi
fi

DSYM_UPLOAD_URL="${APMPlus_UPLOAD_DOMAIN}${DSYM_UPLOAD_PATH}"

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
    echo "APMPlus App ID: ${APMPlus_APP_ID}"
    echo "APMPlus App Token: ${APMPlus_APP_Token}"
    echo "APMPlus Upload domain: ${APMPlus_UPLOAD_DOMAIN}"
    echo "APMPlus Upload URL: ${DSYM_UPLOAD_URL}"
    
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
    
    # 检查上报域名是否设置
    if [ ! "${APMPlus_UPLOAD_DOMAIN}" ]; then
        warningWithMessage "Error: APMPlus upload domain not defined." 1
    fi
    
    function uploadDSYM() {
        DSYM_SRC="$1"
        if [ ! -d "$DSYM_SRC" ]; then
            warningWithMessage "dSYM source not found: ${DSYM_SRC}" 1
        fi
        
        APPID="${APMPlus_APP_ID}"
        
        ZIP_DIR_PATH=$(dirname ${DSYM_SRC})
        FILENAME=$(basename ${DSYM_SRC})
        DSYM_SYMBOL_OUT_ZIP_NAME="APMPlus_dSYM_${APPID}.zip"
        DSYM_ZIP_FPATH="${ZIP_DIR_PATH}/${DSYM_SYMBOL_OUT_ZIP_NAME}"
        cd "${ZIP_DIR_PATH}"
        PAD=$(zip -r ${DSYM_SYMBOL_OUT_ZIP_NAME} ${FILENAME})
        
        if [ ! -e "${DSYM_ZIP_FPATH}" ]; then
            warningWithMessage "no dSYM zip archive generated: ${DSYM_ZIP_FPATH}" 1
        fi
        
        FILESIZE=$(/usr/bin/stat -f%z ${DSYM_ZIP_FPATH})
        echo "dsym size: ${FILESIZE} bytes"
        
        echo "--------------------------------"
        echo "Step 3: Upload the zipped dSYM file."
        echo "--------------------------------"
        MD5ZIP=$(md5 -q ${DSYM_ZIP_FPATH})
        if [ ! ${#MD5ZIP} -eq 32 ]; then
            warningWithMessage "Error: Failed to caculate md5 of zipped file." 1
        fi
        echo "zip md5 : ${MD5ZIP}"
        echo "signature : ${MD5ZIP}"
                
        echo "dSYM upload url: ${DSYM_UPLOAD_URL}"
            
        # Upload dSYM to APMPlus
        echo "curl ${DSYM_UPLOAD_URL} -F \"file=@${DSYM_ZIP_FPATH}\" -F \"type=Dwarf\" -F \"os=iOS\" -F \"aid=${APMPlus_APP_ID}\" -F \"app-token=${APMPlus_APP_Token}\" -F \"script-version=${APMPlus_DYSM_UPLOADER_VERSION}\" -H \"Content-Type: multipart/form-data\" -w %{http_code} -v "
            
        echo "--------------------------------"
            
        # 上传请求
        STATUS=$(curl ${DSYM_UPLOAD_URL} -F "file=@${DSYM_ZIP_FPATH}" -F "type=Dwarf" -F "os=iOS" -F "aid=${APMPlus_APP_ID}" -F "app-token=${APMPlus_APP_ID}" -F "script-version=${APMPlus_DYSM_UPLOADER_VERSION}" -H "Content-Type: multipart/form-data" -w %{http_code} -v)
            
        echo "APMPlus server response: ${STATUS}"

        if [ ${STATUS} = "{\"err_detail\":\"\",\"data\":null,\"error_msg\":\"\",\"error_no\":0}200" ]; then
            echo "Upload dSYM successfully! Delete ${DSYM_SYMBOL_OUT_ZIP_NAME}."
            if [ -f ${DSYM_SYMBOL_OUT_ZIP_NAME} ]; then
                rm ${DSYM_SYMBOL_OUT_ZIP_NAME}
            fi
        else
            echo "Failed to upload dSYM. Try to upload the file at path ${DSYM_SYMBOL_OUT_ZIP_NAME} manually."
        fi
    }
        
    # .dSYM文件信息
    echo "DSYM FOLDER ${DWARF_DSYM_FOLDER_PATH}"
    
    DSYM_FOLDER="${DWARF_DSYM_FOLDER_PATH}"
    
    for i in {1..100};
    do
        sleep 1
        # 遍历目录查找当前工程名的文件
        for dsymFile in $(find "$DSYM_FOLDER" -name "${PRODUCT_NAME}.*.dSYM");
        do
            # 判断压缩文件的源文件是否存在
            DSYM_SINGLE_FILE_NAME="${dsymFile}/Contents/Resources/DWARF/${PRODUCT_NAME}"
            if [ ${UPLOADFLAG} -eq 1 -a -s "${DSYM_SINGLE_FILE_NAME}" ]; then
                echo "Found dSYM file: $dsymFile"
                uploadDSYM $dsymFile
                break 2
            fi
        done
    done
}
    
main
