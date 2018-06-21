python3 generate*.py
cd /etc/init.d
sudo echo ssserver -c /etc/shadowsocks/config.json >> ss.sh

chmod +x ss.sh
sudo update-rc.d ss.sh defaults 95
sudo ssserver -c /etc/shadowsocks/config.json -d start
