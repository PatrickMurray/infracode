# OpenVPN

## Certificate

### Elliptic Curve Key

```bash
openssl ecparam -out key.pem -name secp521r1 -genkey
```


```bash
openssl req -new -key key.pem -x509 -nodes -days 365 -out cert.pem
```
