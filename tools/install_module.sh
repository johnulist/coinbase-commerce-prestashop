
echo Install Module "$1"

# Build Module Dependencies
cd $MODULE_DIR
composer update --prefer-dist --no-interaction --no-progress
cd $TRAVIS_BUILD_DIR

# Move Module Contents to Install Folder
echo Move Module Contents to Prestashop Modules Directory
mkdir     $TRAVIS_BUILD_DIR/modules/$1
cp -Rf    $MODULE_DIR/*              $TRAVIS_BUILD_DIR/modules/$1/      

# Change Default Language Code to ISO format
mysql -D prestashop -e "UPDATE ps_lang SET language_code = 'fr-fr' WHERE ps_lang.language_code = 'fr';"

# Enable the Module
php bin/console prestashop:module install $1
