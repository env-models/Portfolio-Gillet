#!/bin/bash

# This file will be sourced in init.sh

# https://raw.githubusercontent.com/ai-dock/comfyui/main/config/provisioning/default.sh

# Packages are installed after nodes so we can fix them...

#DEFAULT_WORKFLOW="https://..."

APT_PACKAGES=(
    # "python3.10-dev"
    #"package-1"
    #"package-2"
)

PIP_PACKAGES=(
    # #"package-1"
    #  "pillow==10.2.0"
    #  "opencv-python>=4.8.0"
    # "insightface"
    #  # "https://github.com/Gourieff/Assets/raw/main/Insightface/insightface-0.7.3-cp310-cp310-win_amd64.whl "
    #  "onnxruntime"
    #  "onnxruntime-gpu"
    # #"package-2"
)

NODES=(
    "https://github.com/ltdrdata/ComfyUI-Manager/archive/refs/tags/3.0.1.zip"
    # "https://github.com/ltdrdata/ComfyUI-Manager"

    # "https://github.com/ltdrdata/ComfyUI-Manager/releases/tag/3.0.1"
    # "https://github.com/ltdrdata/ComfyUI-Manager/archive/refs/tags/3.0.1.zip"
    "https://github.com/cubiq/ComfyUI_essentials"
    # "https://github.com/Fannovel16/comfyui_controlnet_aux"
    # "https://github.com/cubiq/ComfyUI_IPAdapter_plus"
    "https://github.com/cubiq/ComfyUI_InstantID"
    # "https://github.com/cubiq/ComfyUI_FaceAnalysis"
    

)

CHECKPOINT_MODELS=(
    # "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt"
    # #"https://huggingface.co/stabilityai/stable-diffusion-2-1/resolve/main/v2-1_768-ema-pruned.ckpt"
    # "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors"
    # "https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors"
    # "https://huggingface.co/lllyasviel/fav_models/resolve/main/fav/DreamShaper_8_pruned.safetensors"
    "https://huggingface.co/digiplay/DreamShaper_8/resolve/main/dreamshaper_8.safetensors"
    # "https://huggingface.co/Lykon/dreamshaper-xl-v2-turbo/resolve/main/DreamShaperXL_Turbo_v2.safetensors"
    # "https://huggingface.co/Lykon/dreamshaper-8-inpainting/resolve/main/unet/diffusion_pytorch_model.safetensors"
)

CIVITAI_CHECKPOINT_MODELS=(
    # "https://civitai.com/api/download/models/1074830"
    # 1074830
)


UNET_MODELS=(
    # "https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/flux1-schnell.safetensors"
    # "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors"
    # "https://huggingface.co/Lykon/dreamshaper-8-inpainting/resolve/main/unet/diffusion_pytorch_model.safetensors"
    # "https://huggingface.co/redstonehero/dreamshaper-inpainting/resolve/main/unet/diffusion_pytorch_model.bin"
)


VAE_MODELS=(
    # "https://huggingface.co/stabilityai/sd-vae-ft-ema-original/resolve/main/vae-ft-ema-560000-ema-pruned.safetensors"
    # "https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors"
    # "https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors"
    # "https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors"
    # "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/ae.safetensors"
)

ESRGAN_MODELS=(
    # "https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x4.pth"
    # "https://huggingface.co/FacehugmanIII/4x_foolhardy_Remacri/resolve/main/4x_foolhardy_Remacri.pth"
    # "https://huggingface.co/Akumetsu971/SD_Anime_Futuristic_Armor/resolve/main/4x_NMKD-Siax_200k.pth"
)

CLIP=(
    # "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors"
    # "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"
)

CLIP_VISION=(
    # "https://huggingface.co/laion/CLIP-ViT-H-14-laion2B-s32B-b79K/resolve/main/model.safetensors"
)


FACESTORE_MODELS=(
    # "https://huggingface.co/talhaty/GFPGANv1.4/resolve/main/GFPGANv1.4.pth"
)

FACEDETECTION=(
    # "https://huggingface.co/darkeril/collection/resolve/main/detection_Resnet50_Final.pth"
)

IPADAPTER=(
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sd15.bin"
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sd15.binx"    
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sdxl.bin"
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sdxl.bin"

    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-portrait_sdxl.bin"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus_sd15.safetensors"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus-face_sd15.safetensors"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-full-face_sd15.safetensors"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter_sd15.safetensors"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter_sd15_light_v11.bin"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter_sdxl_vit-h.safetensors"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus_sdxl_vit-h.safetensors"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus-face_sdxl_vit-h.safetensors"
)

LORA_MODELS=(
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sd15_lora.safetensors"
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sd15_lora.safetensors"
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sdxl_lora.safetensors"
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sdxl_lora.safetensors"

    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plus_sd15_lora.safetensors"
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sd15_lora.safetensors"
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sdxl_lora.safetensors"
)


INSIGHTFACE=(
    # "https://huggingface.co/ezioruan/inswapper_128.onnx/resolve/main/inswapper_128.onnx"
    # "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/1k3d68.onnx"
    # "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/2d106det.onnx"
    # "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/det_10g.onnx"
    # "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/genderage.onnx"
    # "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/w600k_r50.onnx"
)



CONTROLNET_MODELS=(
    # "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_canny_mid.safetensors"
    # "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_depth_mid.safetensors?download"
    # "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_openpose.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_canny-fp16.safetensors"
    # "https://huggingface.co/kohya-ss/ControlNet-diff-modules/resolve/main/diff_control_sd15_depth_fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_openpose-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_canny-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_openpose-fp16.safetensors"
)

ULTRALYTICS=(
# "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt"
# "https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8s.pt"
)

VITMATTE=(
# "https://huggingface.co/hustvl/vitmatte-base-composition-1k/resolve/main/pytorch_model.bin"
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
        "${WORKSPACE}/storage/stable_diffusion/models/ultralytics" \
        "${ULTRALYTICS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/vitmatte" \
        "${VITMATTE[@]}"
    # provisioning_has_valid_civitai_token \
    #     "${WORKSPACE}/storage/stable_diffusion/models/ckpt" \
    #     "${CIVITAI_CHECKPOINT_MODELS[@]}"
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
        printf "Preparing to install %d pip package(s):\n" "${#PIP_PACKAGES[@]}"
        for package in "${PIP_PACKAGES[@]}"; do
            printf "Installing pip package: %s\n" "$package"
            # Capture error output from the custom pip_install function
            error_output=$(pip_install "$package" 2>&1)            

            if [[ $? -ne 0 ]]; then
                echo "Error: Failed to install pip package: $package"
                echo "Details: $error_output"
            fi
        done
        printf "All pip packages installed successfully.\n"
    else
        echo "No pip packages to install."
    fi
}


# version 3 

function provisioning_get_nodes() {
    set -x  # Debug mode: prints each command before execution

    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="/opt/ComfyUI/custom_nodes/${dir}"
        requirements="${path}/requirements.txt"

        echo "DEBUG: dir is $dir" >&2
        echo "DEBUG: path is $path" >&2
        echo "DEBUG: Current working directory is $PWD" >&2

        if [[ $repo =~ /archive/refs/tags/ ]]; then
            echo "Downloading source code archive: $repo" >&2
            mkdir -p "$path"
            
            downloaded_file="$path/$(basename "$repo")"
            echo "Downloading file: $(basename "$repo")" >&2
            wget --show-progress --verbose -O "$downloaded_file" "$repo"
            unzip -qo "$downloaded_file" -d "$path"

            # Move extracted files up if necessary
            extracted_folder=$(find "$path" -mindepth 1 -maxdepth 1 -type d | head -n 1)
            if [[ -d "$extracted_folder" && "$extracted_folder" != "$path" ]]; then
                echo "Fixing directory structure..." >&2
                mv "$extracted_folder"/* "$path/"
                rmdir "$extracted_folder"
            fi

            rm "$downloaded_file"

            # Ensure GitPython is installed
            if ! python3 -c "import git" &>/dev/null; then
                echo "GitPython is missing. Installing now..." >&2
                python3 -m pip install gitpython
            fi

            # Install requirements if present
            if [[ -e $requirements ]]; then
                echo "Installing dependencies from: $requirements" >&2
                python3 -m pip install -r "$requirements"
            fi
        fi
    done
}



# # provisioning_get_nodes to get past released of confyui manager
# function provisioning_get_nodes() {
#     for repo in "${NODES[@]}"; do
#         dir="${repo##*/}"  # Extract the last part of the URL or file name        
#         path="/opt/ComfyUI/custom_nodes/${dir}"
#         requirements="${path}/requirements.txt"
#         printf "dir is equal to: %s\n" "$dir" >&2
#         printf "path is equal to : %s\n" "$path" >&2
#         printf "PWD is equal to : %s\n" "$PWD" >&2


#         if [[ $repo =~ /archive/refs/tags/ ]]; then
#             # Handle GitHub source code archive for tags
#             printf "Downloading source code archive: %s...\n" "$repo"
#             mkdir -p "$path"
            
#             downloaded_file="$path/$(basename "$repo")"
#             printf "Showing download  of file : %s\n " "$(basename "$repo")"
#             wget --show-progress --verbose -O "$downloaded_file" "$repo"
#             unzip -qo "$downloaded_file" -d "$path"

#             # Move extracted contents up one level if there's an extra folder
#             extracted_folder=$(find "$path" -mindepth 1 -maxdepth 1 -type d | head -n 1)
#             if [[ -d "$extracted_folder" && "$extracted_folder" != "$path" ]]; then
#                 printf "Fixing directory structure: moving contents from %s to %s\n" "$extracted_folder" "$path"
#                 mv "$extracted_folder"/* "$path/"
#                 rmdir "$extracted_folder"
#             fi

#             # Recheck requirements.txt after moving files
#             if [[ ! -e $requirements ]]; then
#                 new_requirements=$(find "$path" -name "requirements.txt" | head -n 1)
#                 if [[ -n "$new_requirements" ]]; then
#                     requirements="$new_requirements"
#                 fi
#             fi

#             # Check for requirements.txt
#             if [[ -e $requirements ]]; then
#                 printf "Installing requirements for node: %s...\n" "$dir"
#                 pip_install -r "$requirements" || { echo "Failed to install dependencies!"; exit 1; }
#             fi

#             # Clean up the archive after extraction
#             printf "Cleaning up: %s\n" "$(basename "$repo")"
#             rm "$downloaded_file"

            
#         else
#             # Handle Git repositories
#             printf "Downloading node: %s...\n" "$repo"
#             if [[ -d $path ]]; then
#                 printf "Updating node: %s...\n" "$repo"
#                 (cd "$path" && git pull)
#                 if [[ -e $requirements ]]; then
#                     pip_install -r "$requirements"
#                 fi
#             else
#                 git clone "${repo}" "${path}" --recursive
#                 if [[ -e $requirements ]]; then
#                     pip_install -r "$requirements"
#                 fi
#             fi
#         fi
#     done
# }


#Deprecated fct
# function provisioning_get_nodes() {
#     for repo in "${NODES[@]}"; do
#         dir="${repo##*/}"
#         path="/opt/ComfyUI/custom_nodes/${dir}"
#         requirements="${path}/requirements.txt"
#         if [[ -d $path ]]; then
#             if [[ ${AUTO_UPDATE,,} != "false" ]]; then
#                 printf "Updating node: %s...\n" "${repo}"
#                 ( cd "$path" && git pull )
#                 if [[ -e $requirements ]]; then
#                    pip_install -r "$requirements"
#                 fi
#             fi
#         else
#             printf "Downloading node: %s...\n" "${repo}"
#             git clone "${repo}" "${path}" --recursive
#             if [[ -e $requirements ]]; then
#                 pip_install -r "${requirements}"
#             fi
#         fi
#     done
# }



function provisioning_get_default_workflow() {
    if [[ -n $DEFAULT_WORKFLOW ]]; then
        workflow_json=$(curl -s "$DEFAULT_WORKFLOW")
        if [[ -n $workflow_json ]]; then
            echo "export const defaultGraph = $workflow_json;" > /opt/ComfyUI/web/scripts/defaultGraph.js
        fi
    fi
}

# ### FUNCTION 1
function provisioning_get_models() {
    if [[ -z $2 ]]; then return 1; fi
    
    dir="$1"
    mkdir -p "$dir"
    shift
    arr=("$@")
    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    for url in "${arr[@]}"; do
        printf "Downloading: %s\n" "${url}"
        provisioning_download "${url}" "${dir}"
        printf "\n"
    done
}

### FUNCTION 2
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
             printf "Downloading and RENAMING CLIP Model\n"

            # Explicitly define the desired filename
            target_file="${dir}/CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors"

            # Use wget with -O to save the file directly
            wget -qnc  --show-progress -e dotbytes="${3:-4M}" -O "$target_file" "${url}"

        # Check if directory is specifically for ULTRALYTICS
        elif [[ "$dir" == *"ultralytics"* ]]; then
        Create a bbox subfolder and download there
        provisioning_download "${url}" "${dir}/bbox"

        # Check if directory is specifically for INSIGHTFACE
        elif [[ "$dir" == *"insightface"* ]]; then
            # Check if URL belongs to insightface and contains a nested directory
            if [[ "$url" =~ resolve/main/(.+)/ ]]; then
            # if [[ "$url" =~ resolve/main/(.+)/(.+) ]]; then
                nested_dir="${BASH_REMATCH[1]}"
                file_name="${BASH_REMATCH[2]}"
                target_dir="${dir}/${nested_dir}"
                printf "USING target_dir == %s\n" "$target_dir" 
                
                mkdir -p "$target_dir" || { echo "Failed to create directory: $target_dir"; continue; }
                printf "Insightface model detected. Downloading to: %s/%s\n" "$target_dir" "$file_name"

                # Download using provisioning_download
                provisioning_download "$url" "$target_dir"
            else
                # If no nested directory, download directly to the base insightface directory
                printf "Insightface model (no nested directory). Downloading to: %s\n" "$dir"
                provisioning_download "$url" "$dir"
            fi

        # Default case for other directories
        else
            provisioning_download "${url}" "${dir}"
        fi

        printf "\n"
    done
}


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

# Function to validate the Civitai token and optionally download a model

# function provisioning_has_valid_civitai_token() {
#     [[ -n "$CIVITAI_TOKEN" ]] || return 1
#     url="https://civitai.com/api/v1/models?hidden=1&limit=1"

#     response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
#         -H "Authorization: Bearer $CIVITAI_TOKEN" \
#         -H "Content-Type: application/json")

#     # Check if the token is valid
#     if [ "$response" -eq 200 ]; then
#         return 0
#     else
#         return 1
#     fi
# }

function provisioning_has_valid_civitai_token() {
    # Hardcoded Civitai token
    local CIVITAI_TOKEN="8d3612baaafd4ed9db408ff955a3f87c"

    local target_directory="${1:-}"
    local model_id="${2:-}"

    # Ensure the target directory is provided
    if [[ -z "$target_directory" ]]; then
        echo "Error: Target directory is required as the first argument." >&2
        return 1
    fi

    # Ensure the model ID or name is provided
    if [[ -z "$model_id" ]]; then
        echo "Error: Model ID or name is required as the second argument." >&2
        return 1
    fi

    # Ensure the target directory exists
    mkdir -p "$target_directory"

    # Construct the URL for downloading the model
    local url="https://civitai.com/api/download/models/$model_id"
    local output_file="$target_directory/$model_id.safetensors"

    # Attempt to download the model
    echo "Downloading model ID: $model_id to directory: $target_directory"
    curl -H "Authorization: Bearer $CIVITAI_TOKEN" \
         -L -o "$output_file" \
         "$url"

    if [[ $? -eq 0 ]]; then
        echo "Model downloaded successfully: $output_file"
        return 0
    else
        echo "Error: Failed to download model with ID $model_id" >&2
        return 1
    fi
}


provisioning_start
