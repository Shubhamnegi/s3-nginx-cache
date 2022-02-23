# S3 Cache using nginx

## Objective
Idea is to reduce the number of api call on s3 by using a caching layer in b/w. This must also help in reducing the response time and s3 get request cost.

## Implementation
Create an custom path which will check for cache first and if the cache is not available then get data from s3 bucket and cache the result for next attempt.

## Files

- Templates: use template folder to create a template file, here env vars can be used to replace place holders. Any file name with .template will be copied to conf.d folder in nginx
    - caching.conf.template : Config required to store cache.
    - s3.conf.template : Config to route caching requests.
- docker-compose: To create docker container with required config
- nginx.conf: Custom nginx conf. This file is not mandatory if this is not required simply remove mount volume from docker compose i.e
```
    - ./nginx.conf:/etc/nginx/nginx.conf:ro # comment this is nginx.conf is not required
```

## Usage:
Suppose the bucket region name is `ap-southeast-1`, then replace docker-compose.yaml  `NGINX_BUCKET_HOST` with the `s3-ap-southeast-1.amazonaws.com`, and the bucket name is `abc` and  your proxy domain is custom.com the replace `NGINX_HOST` in docker compose with custom.com.

The url should look like `curl -XGET -i "http://custom.com/s3_cached/abc/file.json"        `

## References: 
https://www.scaleway.com/en/docs/tutorials/setup-nginx-reverse-proxy-s3/
https://github.com/nginxinc/nginx-s3-gateway
