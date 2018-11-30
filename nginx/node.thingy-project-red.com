server {
    server_name node.thingy-project-red.com;

    location / {
        proxy_pass http://127.0.0.1:1880;
    }

    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/node.thingy-project-red.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/node.thingy-project-red.com/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
}
