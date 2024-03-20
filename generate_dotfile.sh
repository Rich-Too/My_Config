#!/bin/bash
# du -h --max-depth=1
# exclude google-chrome weixin JetBrains clash_win sublime-text LarkShell QQ Code coc obsidian microsoft-edge DingTalk
# 要排除的文件夹列表
exclude_folders=("fcitx" "google-chrome" "weixin" "JetBrains" "clash_win" "sublime-text" "LarkShell" "QQ" "Code" "coc" "obsidian" "microsoft-edge" "DingTalk" "ibus" "bilibili" "Neo4j Desktop")
exclude_files=()

# 目标文件夹路径
target_folder="./kde_config"

# 创建目标文件夹
mkdir -p "$target_folder"

# 移动文件夹内容到目标文件夹
for entry in ~/.config/*; do
    if [ -d "$entry" ]; then
        folder_name=$(basename "$entry")

        # 检查文件夹是否需要排除
        if [[ " ${exclude_folders[@]} " =~ " ${folder_name} " ]]; then
            echo "Skipping folder: $folder_name"
        else
            cp -R "$entry" "$target_folder/"
            echo "Moved $folder_name to $target_folder"
        fi
    elif [ -f "$entry" ]; then
        file_name=$(basename "$entry")

        # 检查文件是否需要排除
        if [[ ! " ${exclude_files[@]} " =~ " ${file_name%.*} " ]]; then
            cp -R "$entry" "$target_folder/"
            echo "Moved $file_name to $target_folder"
        fi
    fi
done
