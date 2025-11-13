#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' 

print_status() {
    echo -e "${CYAN}[${2}/${3}] ${BLUE}${1}${NC}"
}

print_success() {
    echo -e "${GREEN}✓ ${1}${NC}"
}

print_error() {
    echo -e "${RED}✗ ${1}${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ ${1}${NC}"
}

print_info() {
    echo -e "${PURPLE}ℹ ${1}${NC}"
}

echo -e "${CYAN}"
echo "╔════════════════════════════════════════╗"
echo "║          สคริปต์ติดตั้งออโต้           ║"
echo "║            Auto Setup Script           ║"
echo "╚════════════════════════════════════════╝"
echo -e "${NC}"

total_steps=8
current_step=1

print_status "ตั้งค่าการเข้าถึงที่เก็บ..." $current_step $total_steps
termux-setup-storage
print_success "ตั้งค่าการเข้าถึงที่เก็บเรียบร้อย"
((current_step++))

sleep 2

print_status "อัพเดทแพ็คเกจ..." $current_step $total_steps
pkg update && pkg upgrade -y
print_success "อัพเดทแพ็คเกจเรียบร้อย"
((current_step++))

print_status "สร้างโฟลเดอร์ runpy..." $current_step $total_steps
mkdir -p /storage/emulated/0/runpy
print_success "สร้างโฟลเดอร์ runpy เรียบร้อย"
((current_step++))

print_status "ดาวน์โหลด menu.sh..." $current_step $total_steps
cd /storage/emulated/0/runpy
if curl -L -o menu.sh "https://raw.githubusercontent.com/opossa/App-update-/refs/heads/main/menu.sh"; then
    if [ -f "menu.sh" ]; then
        print_success "ดาวน์โหลด menu.sh สำเร็จ!"
    else
        print_error "ดาวน์โหลด menu.sh ล้มเหลว!"
        exit 1
    fi
else
    print_error "ไม่สามารถดาวน์โหลด menu.sh ได้"
    exit 1
fi
((current_step++))

print_status "ให้สิทธิ์การรัน..." $current_step $total_steps
chmod +x menu.sh
print_success "ให้สิทธิ์การรันเรียบร้อย"
((current_step++))

print_status "เพิ่ม alias..." $current_step $total_steps
if ! grep -q "alias m='bash /storage/emulated/0/runpy/menu.sh'" ~/.bashrc; then
    echo "alias m='bash /storage/emulated/0/runpy/menu.sh'" >> ~/.bashrc
    print_success "เพิ่ม alias สำเร็จ!"
else
    print_warning "พบ alias อยู่แล้ว!"
fi
((current_step++))

print_status "ติดตั้ง Python และ pip..." $current_step $total_steps
pkg install python -y
pkg install python-pip -y
print_success "ติดตั้ง Python และ pip เรียบร้อย"
((current_step++))

print_status "ติดตั้ง requests..." $current_step $total_steps
pip install requests
print_success "ติดตั้ง requests เรียบร้อย"
((current_step++))

print_info "โหลดการตั้งค่าใหม่..."
source ~/.bashrc

echo -e "${GREEN}"
echo "╔════════════════════════════════════════╗"
echo "║        การติดตั้งเสร็จสมบูรณ์!        ║"
echo "║         Installation Complete!         ║"
echo "╚════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${CYAN}════════════════════════════════════════${NC}"
echo -e "${GREEN}🎉 ติดตั้งสำเร็จ! คุณสามารถใช้คำสั่งต่อไปนี้ได้:${NC}"
echo -e "${YELLOW}   m ${NC}- รันเมนูหลัก"
echo -e ""
echo -e "${CYAN}📝 หมายเหตุ:${NC}"
echo -e "${YELLOW}   หากคำสั่ง 'm' ยังไม่ทำงาน${NC}"
echo -e "${YELLOW}   ให้ปิดและเปิด Termux ใหม่${NC}"
echo -e "${YELLOW}   หรือรันคำสั่ง: ${CYAN}source ~/.bashrc${NC}"
echo -e "${CYAN}════════════════════════════════════════${NC}"