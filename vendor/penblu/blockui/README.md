Example Extension
=================
Extension de ejemplo creada por PenBlu

Installation
------------

The preferred way to install this extension is through [composer](http://getcomposer.org/download/).

Either run

```
php composer.phar require --prefer-dist penblu/example "*"
```

or add

```
"penblu/blockui": "*"
```

to the require section of your `composer.json` file.


Usage
-----

Once the extension is installed, simply use it in your code by  :

```php
<?= \penblu\blockui\Blockui::widget(); ?>```

Pasos a Seguir:

The extension has been generated successfully.
To enable it in your application, you need to create a git repository and require it via composer.

cd /Applications/XAMPP/xamppfiles/htdocs/framework/vendor/penblu/example

git init
git add -A
git commit
git remote add origin https://path.to/your/repo
git push -u origin master
The next step is just for initial development, skip it if you directly publish the extension on packagist.org
Add the newly created repo to your composer.json.

"repositories":[
    {
        "type": "git",
        "url": "https://path.to/your/repo"
    }
]
Note: You may use the url file:///Applications/XAMPP/xamppfiles/htdocs/framework/vendor/penblu/example for testing.
Require the package with composer

composer.phar require penblu/example:dev-master
And use it in your application.

\penblu\example\AutoloadExample::widget();
When you have finished development register your extension at https://packagist.org/.
