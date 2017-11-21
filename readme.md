# PHP-FPM Docker image for SilverStripe

Docker image for a php-fpm container crafted to run SilverStripe based applications.

## Specifications:

* PHP 5.6
* OpenSSL PHP Extension
* Mbstring PHP Extension
* Tokenizer PHP Extension
* Dom PHP Extension
* Fileinfo PHP Extension
* Hash PHP Extension
* Iconv PHP Extension
* Zip PHP Extension
* PDO PHP Extension
* MySQLi PHP Extension
* MySQL and PgSQL Support
* SimpleXML and XML PHP Extension
* GD2 PHP Extension
* XCache (with Optimizer and Coverager)
* Composer
* PHP ini values for SilverStripe (see [`silverstripe.ini`](/silverstripe.ini))
* xDebug (PHPStorm friendly, see [`xdebug.ini`](/xdebug.ini))
* `ss` alias created to run SilverStripe CLI `php public/framework/cli-script.php` with `docker-compose exec [service_name] ss` so you can run `docker-compose exec [service_name] ss dev/build` for example.

## Tags available:

When calling the image you want to use within your `docker-compose.yml` file,
you can specify a tag for the image. Tags are used for various versions of a
given Docker image. By default, `latest` is the one used when no tag is specified.

* `latest` which is using PHP 7.0 for SilverStripe `3.6+`.
* `5.6` for SilverStripe `3.5` and lower.

## docker-compose usage:

```yml
version: '2'
services:
    php-fpm:
        image: cyberduck/php-fpm-silverstripe(:<optional-tag>)
        volumes:
            - ./:/var/www/
            - ~/.ssh:/root/.ssh # can be useful for composer if you use private CVS
        networks:
            - my_net #if you're using networks between containers
```
