server {
    server_name node.thingy-project-red.com;

    location / {
        if ($scheme = http) {
            return 301 https://$host$request_uri;
        }
        proxy_pass http://localhost:1880;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    listen 80;
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/node.thingy-project-red.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/node.thingy-project-red.com/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
}
