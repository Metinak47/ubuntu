#!/bin/bash
set -e

# تغییر mirror های Ubuntu/Debian به ArvanCloud
sed -i 's|http://[a-z]*.archive.ubuntu.com|http://mirror.arvancloud.ir|g' /etc/apt/sources.list
sed -i 's|http://deb.debian.org/debian|http://mirror.arvancloud.ir/debian|g' /etc/apt/sources.list

# آپدیت پکیج لیست
apt update

# جایگزین کردن DNS ها
cat > /etc/resolv.conf <<EOF
nameserver 178.22.122.100
nameserver 185.51.200.2
EOF

# اضافه یا آپدیت کردن raw.githubusercontent.com
if grep -q "raw.githubusercontent.com" /etc/hosts; then
    sed -i 's/.*raw.githubusercontent.com.*/185.199.108.133 raw.githubusercontent.com/' /etc/hosts
else
    echo "185.199.108.133 raw.githubusercontent.com" >> /etc/hosts
fi

echo "Done!"
