# PHP-FPM Docker image for SilverStripe 3.6+

Docker image for a php-fpm container crafted to run SilverStripe 3.6+ based applications.

**Note:** For SilverStripe 3.5 and lower you can use the image available on the `5.6` branch.

## Specifications:

* PHP 5.6, 7.0, 7.1, 7.2, 7.3, 7.4
* OpenSSL PHP Extension
* Mbstring PHP Extension
* Tokenizer PHP Extension
* Dom PHP Extension
* Fileinfo PHP Extension
* Hash PHP Extension
* Iconv PHP Extension
* Intl PHP Extension
* Zip PHP Extension
* PDO PHP Extension
* MySQL and PgSQL Support via MySQLi and PgSQL PHP Extensions
* SimpleXML and XML PHP Extension
* GD2 PHP Extension
* OP Cache PHP Extension
* Composer
* PHP ini values for SilverStripe (see [`silverstripe.ini`](/silverstripe.ini))
* xDebug (PHPStorm friendly, see [`xdebug.ini`](/xdebug.ini))
* `ss` alias created to run SilverStripe CLI `php public/framework/cli-script.php` with `docker-compose exec [service_name] ss` so you can run `docker-compose exec [service_name] ss dev/build` for example.

## Tags available:

When calling the image you want to use within your `docker-compose.yml` file,
you can specify a tag for the image. Tags are used for various versions of a
given Docker image. By default, `latest` is the one used when no tag is specified.

* `7.x` for SilverStripe `3.6+` using PHP 7.x.
* `5.6` for SilverStripe `3.5` and lower using PHP 5.6.

Note: the master branch is not used for generating images, used for documentation instead. Only tags/branches are.

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
