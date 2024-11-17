#!/bin/bash

# This file will be sourced in init.sh

# https://raw.githubusercontent.com/ai-dock/comfyui/main/config/provisioning/default.sh

# Packages are installed after nodes so we can fix them...

#DEFAULT_WORKFLOW="https://..."

APT_PACKAGES=(
    #"package-1"
    #"package-2"
)

PIP_PACKAGES=(
    #"package-1"
    #"package-2"
)

NODES=(
    "https://github.com/ltdrdata/ComfyUI-Manager"
    "https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/Fannovel16/comfyui_controlnet_aux"
    "https://github.com/cubiq/ComfyUI_IPAdapter_plus"
    "https://github.com/cubiq/ComfyUI_InstantID"
    "https://github.com/cubiq/ComfyUI_FaceAnalysis"
    "https://github.com/Gourieff/comfyui-reactor-node"
    "https://github.com/BlenderNeko/ComfyUI_Noise"
    "https://github.com/ltdrdata/ComfyUI-Impact-Pack"
)

CHECKPOINT_MODELS=(
    # "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt"
    # #"https://huggingface.co/stabilityai/stable-diffusion-2-1/resolve/main/v2-1_768-ema-pruned.ckpt"
    # "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors"
    # "https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors"
    "https://huggingface.co/lllyasviel/fav_models/resolve/main/fav/DreamShaper_8_pruned.safetensors"
    "https://huggingface.co/Lykon/dreamshaper-xl-v2-turbo/resolve/main/DreamShaperXL_Turbo_v2.safetensors"
    "https://huggingface.co/redstonehero/dreamshaper-inpainting/resolve/main/unet/diffusion_pytorch_model.bin"


)

UNET_MODELS=(
    # flux1-dev.safetensors
   # "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors"
    # "https://huggingface.co/Lykon/dreamshaper-8-inpainting/resolve/main/unet/diffusion_pytorch_model.safetensors"
    # "https://huggingface.co/redstonehero/dreamshaper-inpainting/resolve/main/unet/diffusion_pytorch_model.bin"
)

LORA_MODELS=(
    # "https://civitai.com/api/download/models/16576"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sd15_lora.safetensors"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sd15_lora.safetensors"
)

VAE_MODELS=(
    "https://huggingface.co/stabilityai/sd-vae-ft-ema-original/resolve/main/vae-ft-ema-560000-ema-pruned.safetensors"
    "https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors"
    "https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors"
)

ESRGAN_MODELS=(
    "https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x4.pth"
    "https://huggingface.co/FacehugmanIII/4x_foolhardy_Remacri/resolve/main/4x_foolhardy_Remacri.pth"
    "https://huggingface.co/Akumetsu971/SD_Anime_Futuristic_Armor/resolve/main/4x_NMKD-Siax_200k.pth"
)

CLIP=(
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors"
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"
)

CLIP_VISION=(
    "https://huggingface.co/laion/CLIP-ViT-H-14-laion2B-s32B-b79K/resolve/main/model.safetensors"
)

INSIGHTFACE=(
    "https://huggingface.co/ezioruan/inswapper_128.onnx/resolve/main/inswapper_128.onnx"
)

FACESTORE_MODELS=(
    "https://huggingface.co/talhaty/GFPGANv1.4/resolve/main/GFPGANv1.4.pth"
)

FACEDETECTION=(
    "https://huggingface.co/darkeril/collection/resolve/main/detection_Resnet50_Final.pth"
)

IPADAPTER=(
    "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter_sd15.safetensors"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus_sd15.safetensors"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus-face_sd15.safetensors"

    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sd15.bin"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-portrait_sdxl.bin"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sdxl.bin"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sd15.binx"
    
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter_sd15_light_v11.bin"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-full-face_sd15.safetensors"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter_sdxl_vit-h.safetensors"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus_sdxl_vit-h.safetensors"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus-face_sdxl_vit-h.safetensors"
)

INSIGHTFACE=(
"https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/1k3d68.onnx"
"https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/2d106det.onnx"
"https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/det_10g.onnx"
"https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/genderage.onnx"
"https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/w600k_r50.onnx"

)



CONTROLNET_MODELS=(
    "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_canny_mid.safetensors"
    "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_depth_mid.safetensors?download"
    "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_openpose.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_canny-fp16.safetensors"
    # "https://huggingface.co/kohya-ss/ControlNet-diff-modules/resolve/main/diff_control_sd15_depth_fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_openpose-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_canny-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_openpose-fp16.safetensors"
)

ULTRALYTICS=(
"https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt"
"https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8s.pt"
)

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    if [[ ! -d /opt/environments/python ]]; then 
        export MAMBA_BASE=true
    fi
    source /opt/ai-dock/etc/environment.sh
    source /opt/ai-dock/bin/venv-set.sh comfyui

    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_nodes
    provisioning_get_pip_packages
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/ckpt" \
        "${CHECKPOINT_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/unet" \
        "${UNET_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/lora" \
        "${LORA_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/controlnet" \
        "${CONTROLNET_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/vae" \
        "${VAE_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/esrgan" \
        "${ESRGAN_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/insightface" \
        "${INSIGHTFACE[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/facestore_models" \
        "${FACESTORE_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/facedetection" \
        "${FACEDETECTION[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/ipadapter" \
        "${IPADAPTER[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/clip" \
        "${CLIP[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/clip_vision" \
        "${CLIP_VISION[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/insightface" \
        "${INSIGHTFACE[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/ultralytics" \
        "${ULTRALYTICS[@]}"
    provisioning_print_end
}





function pip_install() {
    if [[ -z $MAMBA_BASE ]]; then
            "$COMFYUI_VENV_PIP" install --no-cache-dir "$@"
        else
            micromamba run -n comfyui pip install --no-cache-dir "$@"
        fi
}

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then
            sudo $APT_INSTALL ${APT_PACKAGES[@]}
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
            pip_install ${PIP_PACKAGES[@]}
    fi
}

function provisioning_get_nodes() {
    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="/opt/ComfyUI/custom_nodes/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating node: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then
                   pip_install -r "$requirements"
                fi
            fi
        else
            printf "Downloading node: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                pip_install -r "${requirements}"
            fi
        fi
    done
}

function provisioning_get_default_workflow() {
    if [[ -n $DEFAULT_WORKFLOW ]]; then
        workflow_json=$(curl -s "$DEFAULT_WORKFLOW")
        if [[ -n $workflow_json ]]; then
            echo "export const defaultGraph = $workflow_json;" > /opt/ComfyUI/web/scripts/defaultGraph.js
        fi
    fi
}

# ### FUNCTION 1
# function provisioning_get_models() {
#     if [[ -z $2 ]]; then return 1; fi
    
#     dir="$1"
#     mkdir -p "$dir"
#     shift
#     arr=("$@")
#     printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
#     for url in "${arr[@]}"; do
#         printf "Downloading: %s\n" "${url}"
#         provisioning_download "${url}" "${dir}"
#         printf "\n"
#     done
# }

### FUNCTION 2
# function provisioning_get_models() {
#     if [[ -z $2 ]]; then return 1; fi

#     dir="$1"
#     mkdir -p "$dir"
#     shift
#     arr=("$@")

#     printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
#     for url in "${arr[@]}"; do
#         printf "Downloading: %s\n" "${url}"
        
#         # Check if directory is specifically for CLIP_VISION
#         if [[ "$dir" == *"clip_vision"* ]]; then

#             # Extract the desired part of the URL for the filename
#             base_name=$(basename "$url" | sed 's/model.safetensors/CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors/')
#             provisioning_download "${url}" "${dir}/${base_name}"
#         else
#             # Default download for other directories
#             provisioning_download "${url}" "${dir}"
#         fi

#         printf "\n"
#     done
# }


### FUNCTION 3
function provisioning_get_models() {
    if [[ -z $2 ]]; then return 1; fi

    dir="$1"
    mkdir -p "$dir"
    shift
    arr=("$@")

    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    
    for url in "${arr[@]}"; do
        printf "Downloading: %s\n" "${url}"
        
        # Check if directory is specifically for CLIP_VISION
        if [[ "$dir" == *"clip_vision"* ]]; then
            # Extract the desired part of the URL for the filename
            base_name=$(basename "$url" | sed 's/model.safetensors/CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors/')
            provisioning_download "${url}" "${dir}/${base_name}"

        # Check if directory is specifically for ULTRALYTICS
        elif [[ "$dir" == *"ultralytics"* ]]; then
            # Create a bbox subfolder and download there
            provisioning_download "${url}" "${dir}/bbox"

        # Default case for other directories
        else
            provisioning_download "${url}" "${dir}"
        fi

        printf "\n"
    done
}


        wget -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"






function provisioning_print_header() {
    printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
    if [[ $DISK_GB_ALLOCATED -lt $DISK_GB_REQUIRED ]]; then
        printf "WARNING: Your allocated disk size (%sGB) is below the recommended %sGB - Some models will not be downloaded\n" "$DISK_GB_ALLOCATED" "$DISK_GB_REQUIRED"
    fi
}

function provisioning_print_end() {
    printf "\nProvisioning complete:  Web UI will start now\n\n"
}

function provisioning_has_valid_hf_token() {
    [[ -n "$HF_TOKEN" ]] || return 1
    url="https://huggingface.co/api/whoami-v2"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $HF_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

function provisioning_has_valid_civitai_token() {
    [[ -n "$CIVITAI_TOKEN" ]] || return 1
    url="https://civitai.com/api/v1/models?hidden=1&limit=1"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $CIVITAI_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

# Download from $1 URL to $2 file path
function provisioning_download() {
    if [[ -n $HF_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?huggingface\.co(/|$|\?) ]]; then
        auth_token="$HF_TOKEN"
    elif 
        [[ -n $CIVITAI_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?civitai\.com(/|$|\?) ]]; then
        auth_token="$CIVITAI_TOKEN"
    fi
    if [[ -n $auth_token ]];then
        wget --header="Authorization: Bearer $auth_token" -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    else
        wget -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    fi
}

provisioning_start
