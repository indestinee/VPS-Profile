import os, json, random

def random_str(n):
	s = '1234567890qwertyuioplkjhgfdsazxcvbnmQWERTYUIOPLKJHGFDSAZXCVBNM'
	x = ''.join(random.sample(s, 16))
	return x

data = {
    "server":"::",
    "server_port":8388,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":random_str(16),
    "timeout":300,
    "method":"aes-256-cfb",
    "workers": 1
}

out = json.dumps(data)
print(out)
with open('/etc/shadowsocks/config.json', 'w') as f:
	json.dump(data, f)


