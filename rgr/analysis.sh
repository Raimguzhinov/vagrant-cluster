#!/bin/bash
echo -e "\033[91mДата:\033[0m"
echo "------------$(date)"
echo -e "\033[91mИмя учетной записи:\033[0m"
echo "------------$(id)"
echo -e "\033[91mоменное имя ПК:\033[0m"
echo "------------$(hostname)"
echo -e "\033[91mПроцессор:\033[0m"
echo "   Модель:"
echo "------------$(lscpu | grep "Model name:" | awk -F: '{print $2}' | sed 's/^[ \t]*//')"
echo "   Архитектура:"
echo "------------$(lscpu | grep "Architectrure:" | awk '{print $2}')"
echo "   Тактовая частота максимальная:"
echo "------------$(lscpu | grep "CPU MHz:" | awk -F: '{print $2}' | sed 's/^[ \t]*//')"
echo "   Количество ядер:"

echo "------------$(lscpu | grep "Core(s) per socket" | awk -F: '{print $2}' | sed 's/^[ \t]*//')"
echo "   Количество потоков на одно ядро:"

echo "------------$(lscpu | grep "Thread(s) per core" | awk -F: '{print $2}' | sed 's/^[ \t]*//')"
echo "   Загрузка процессора"
echo "------------$(top -b -n 1 | grep "load average" | awk '{print $11}')"


echo -e "\033[91mОперативная память\033[0m"
echo "   Cache L1:"
echo "------------$(lscpu | grep "L1i" | awk -F: '{print $2}' | sed 's/^[ \t]*//')"

echo "   Cache L2:"
echo "------------$(lscpu | grep "L2" | awk -F: '{print $2}' | sed 's/^[ \t]*//')"
echo "   Cache L3:"
echo "------------$(lscpu | grep "L3" | awk -F: '{print $2}' | sed 's/^[ \t]*//')"
echo "   Всего"

echo "------------$(free -h | grep "Mem:" | awk '{print $2}')"
echo "   Доступно"
echo "------------$(free -h | grep "Mem:" | awk '{print $4}')"

echo -e "\033[91mЖесткий диск\033[0m"
echo "   Всего"
echo "------------$(df -h | grep "/dev/sda1" | awk '{print $2}')"
echo "  Доступно"
echo "------------$(df -h | grep "/dev/sda1" | awk '{print $4}')"
echo "  Количество разделов"
#echo "------------$(lsblk -o NAME | grep -v NAME)"
echo "------------$(lsblk -o NAME | grep -v NAME | wc -l)"
echo "   SWAP Всего"
echo "------------$(free -h | grep "Swap:" | awk '{print $2}')"


echo "   SWAP Доступно"
echo "------------$(free -h | grep "Swap:" | awk '{print $4}')"
