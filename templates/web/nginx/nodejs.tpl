server {
    listen      %ip%:%proxy_port%;
    server_name %domain_idn% %alias_idn%;
    error_log  /var/log/%web_system%/domains/%domain%.error.log error;
    
    root %sdocroot%;
    index index.html;

    location / {
        proxy_pass      http://NODEJS_HOSTNAME:65535;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;


        try_files $uri $uri/ @rewrites;

        location ~* ^.+\.(%proxy_extentions%)$ {
            access_log     /var/log/%web_system%/domains/%domain%.log combined;
            access_log     /var/log/%web_system%/domains/%domain%.bytes bytes;
            expires        max;
        }
    }

    location @rewrites {
      rewrite ^(.+)$ /index.html last;
    }

    location /error/ {
        alias   %home%/%user%/web/%domain%/document_errors/;
    }


    location ~ /\.ht    {return 404;}
    location ~ /\.svn/  {return 404;}
    location ~ /\.git/  {return 404;}
    location ~ /\.hg/   {return 404;}
    location ~ /\.bzr/  {return 404;}

    include %home%/%user%/conf/web/*nginx.%domain_idn%.conf_letsencrypt;
    include %home%/%user%/conf/web/s%proxy_system%.%domain%.conf*;
}
