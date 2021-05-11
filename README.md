# README


Setup & Dependencies:
1. Git --Version 2.7.4
2. Node --Version 14.16.1
3. RVM --version 1.29.10 
4. Ruby --version 2.6.3
5. Rails --version 6.0.3
6. Bundler --version 2.1.4
7. Mysql --Version 14.14 Distrib 5.7.33
8. Redis --Version 6.2.2
9. Nginx --Version 1.17.0

Steps are necessary to get the application up and running.
1. Setup configuration.yml with required environvent variables to store sensitive information. This file is not added in git for security reasons.
2. Create the databse if not created earlier: rake db:create
3. Install the bundle: bundle install
4. Migrate the latest migrations added: rake db:migrate
5. Now start the rails server: rails server

Used Third-Parties
1. Amazon Web Services
2. Redis server
3. MySQL Server

Application Hosting Plan: 
Cloud Plateform: AWS Services 
Services to be used:
1. EC2 for hosting
2. Route 53 for DNS management
3. S3 bucket for uploading assets images, videos, docs etc
4. Cloudfront for assets CDN
