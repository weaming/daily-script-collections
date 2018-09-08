alias sps='supervisorctl status'
alias spr='supervisorctl reload'
alias spu='supervisorctl update'

TZ_CHINA=Asia/Shanghai
export TZ=$TZ_CHINA
export CRON_TZ=$TZ

certbot-application() {
    # apt install certbot
    sudo certbot certonly --authenticator standalone --pre-hook "nginx -s stop" --post-hook "nginx"
}

certbot-renew() {
    nginx -s stop
    sudo certbot renew
    nginx
}

ngx-generate-dhparams.pem() {
    openssl dhparam -out dhparams.pem 2048
}

ngx-example-https-conf() {
    cat <<EOF
server {
    listen 80;
    listen 443 ssl http2;
    ssl_certificate	/etc/letsencrypt/live/bitsflow.org/fullchain.pem;
    ssl_certificate_key	/etc/letsencrypt/live/bitsflow.org/privkey.pem;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3

    ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA';
    ssl_prefer_server_ciphers on;
    ssl_dhparam /usr/local/nginx/dhparams.pem;

    # header for https
    add_header	Content-Security-Policy "default-src https:; script-src 'unsafe-inline' 'unsafe-eval' blob: https:; connect-src 'unsafe-inline' 'unsafe-eval' blob: ws: wss: http: https:; img-src data: https: http:; style-src 'unsafe-inline' https:; child-src https:;";

    if (\$scheme != "https") {
        rewrite ^ https://\$host\$uri permanent;
    }

    server_name  bitsflow.org;
    default_type  text/plain;
    sendfile        on;
    keepalive_timeout  30;

    # static file server
    autoindex on;
    autoindex_exact_size off;

    location / {
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$remote_addr;
        proxy_pass http://127.0.0.1:8080;
        index  index.html;
    }
}
EOF
}
