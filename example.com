server {
        listen   80; 
	#listen for ipv4; this line is default and implied
        #listen   [::]:80 default ipv6only=on; ## listen for ipv6

        root /usr/share/nginx/partner-api/public;
        index index.html index.htm index.php;

        # Make site accessible from http://localhost/
        server_name partner-api.com;

        location / {
                try_files $uri $uri/ /index.php?$query_string;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php8.0-fpm.sock;
        }

        location ~ /\.ht {
                deny all;
        }
}

