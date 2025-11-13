#!/bin/bash
clear

VERSION="1.0.5"
MENU_WIDTH=80
PYTHON_DIR="/storage/emulated/0/runpy/"
LEFT_PADDING="    "

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
MAGENTA='\033[1;35m'
BOLD='\033[1m'
NC='\033[0m'

GRADIENT1='\033[38;5;51m'   
GRADIENT2='\033[38;5;45m'   
GRADIENT3='\033[38;5;39m'   
GRADIENT4='\033[38;5;33m'   
GRADIENT5='\033[38;5;27m'   

menu_items=(
    "Base64" "AES" "AESM2" "AESM2A" "MD5"
    "PullEiles" "Hex" "Base32" "Ascii" "Binary"
    "SHA-1" "SHA-256 / SHA-512" "URLEncode" "ROT13" "UTF-8"
    
)

function show_logo() {
    echo -e "${LEFT_PADDING}${GRADIENT1}╔═══════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LEFT_PADDING}${GRADIENT1}║${GRADIENT2}                                                                           ${GRADIENT1}║${NC}"
    echo -e "${LEFT_PADDING}${GRADIENT2}║${GRADIENT3}     ██████╗ ██╗   ██╗ ██████╗  ██████╗                                  ${GRADIENT2}  ║${NC}"
    echo -e "${LEFT_PADDING}${GRADIENT2}║${GRADIENT3}     ██╔══██╗╚██╗ ██╔╝██╔════╝ ██╔════╝                                  ${GRADIENT2}  ║${NC}"
    echo -e "${LEFT_PADDING}${GRADIENT3}║${GRADIENT4}     ██████╔╝ ╚████╔╝ ██║  ███╗██║  ███╗                                 ${GRADIENT3}  ║${NC}"
    echo -e "${LEFT_PADDING}${GRADIENT3}║${GRADIENT4}     ██╔══██╗  ╚██╔╝  ██║   ██║██║   ██║                                 ${GRADIENT3}  ║${NC}"
    echo -e "${LEFT_PADDING}${GRADIENT4}║${GRADIENT5}     ██████╔╝   ██║   ╚██████╔╝╚██████╔╝                                 ${GRADIENT4}  ║${NC}"
    echo -e "${LEFT_PADDING}${GRADIENT4}║${GRADIENT5}     ╚═════╝    ╚═╝    ╚═════╝  ╚═════╝                                  ${GRADIENT4}  ║${NC}"
    echo -e "${LEFT_PADDING}${GRADIENT5}║${GRADIENT4}                                                                           ${GRADIENT5}║${NC}"
    echo -e "${LEFT_PADDING}${GRADIENT5}║${MAGENTA}                ⚡ ${BOLD}${WHITE}Python Script Manager ${NC}${MAGENTA} ⚡                     ${GRADIENT5}          ║${NC}"
    echo -e "${LEFT_PADDING}${GRADIENT5}╚═══════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

function show_header() {
    show_logo
    echo -e "${LEFT_PADDING}${YELLOW}╔══════════════════════════════════════════════════════════════════════════╗${NC}"
    printf "${LEFT_PADDING}${YELLOW}║${CYAN}%*s%*s${YELLOW}                   ║${NC}\n" $(((MENU_WIDTH-18)/2)) "📋 เมนูสคริปต์ (${#menu_items[@]} รายการ)" $(((MENU_WIDTH-18)/2)) ""
    echo -e "${LEFT_PADDING}${YELLOW}╠══════════════════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${LEFT_PADDING}${BLUE}🔹 เวอร์ชั่น: ${WHITE}${VERSION}${NC}   ${GREEN}🔹 สถานะ: ${WHITE}พร้อมใช้งาน ✅${NC}\n"
}

function show_menu() {
    for ((i=0; i<${#menu_items[@]}; i+=2)); do
        printf "${LEFT_PADDING}${WHITE}[${GREEN}%2d${WHITE}]${CYAN} %-30s" "$((i+1))" "${menu_items[i]}"
        if ((i+1 < ${#menu_items[@]})); then
            printf "${WHITE}[${GREEN}%2d${WHITE}]${CYAN} %s${NC}" "$((i+2))" "${menu_items[i+1]}"
        fi
        echo
    done
    echo -e "\n${LEFT_PADDING}${YELLOW}╚══════════════════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${LEFT_PADDING}${RED}[ 0 ] 🚪 ออกจากโปรแกรม${NC}"
}

while true; do
    clear
    show_header
    show_menu
    echo
    echo -e "${LEFT_PADDING}${BOLD}${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -ne "${LEFT_PADDING}${BOLD}${CYAN}👉 เลือกหมายเลข (0-${#menu_items[@]}): ${NC}"
    read choice

    if [[ ! "$choice" =~ ^[0-9]+$ ]] || (( choice < 0 || choice > ${#menu_items[@]} )); then
        echo -e "${LEFT_PADDING}${RED}❌ กรุณากรอกตัวเลขที่ถูกต้อง!${NC}"
        sleep 1.5
        continue
    fi

    if (( choice == 0 )); then
        echo -e "\n${LEFT_PADDING}${MAGENTA}╔═══════════════════════════════════════╗${NC}"
        echo -e "${LEFT_PADDING}${MAGENTA}║   ${BOLD}${WHITE}👋 ขอบคุณที่ใช้งาน BYGG! 💖${NC}${MAGENTA}             ║${NC}"
        echo -e "${LEFT_PADDING}${MAGENTA}╚═══════════════════════════════════════╝${NC}"
        sleep 1
        break
    fi

    selected_script="${menu_items[choice-1]}.py"
    echo -e "\n${LEFT_PADDING}${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${LEFT_PADDING}${GREEN}✨ กำลังรันสคริปต์: ${BOLD}${WHITE}${selected_script}${NC}"
    echo -e "${LEFT_PADDING}${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    cd "$PYTHON_DIR" || { echo -e "${LEFT_PADDING}${RED}❌ ไม่พบไดเรกทอรี Python${NC}"; exit 1; }
    python "$selected_script"
    
    echo -e "\n${LEFT_PADDING}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -ne "${LEFT_PADDING}${BOLD}${MAGENTA}⏎ กด [Enter] เพื่อกลับสู่เมนู...${NC}"
    read
done