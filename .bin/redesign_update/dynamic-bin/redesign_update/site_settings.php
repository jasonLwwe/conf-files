#! /bin/env drush

variable_realm_set('language', 'en', 'site_name', 'www.wwe.com');
variable_realm_set('language', 'de', 'site_name', 'de.wwe.com');
variable_realm_set('language', 'es', 'site_name', 'espanol.wwe.com');

variable_set('maintenance_mode_message', 'www.wwe.com is currently under maintenance. We should be back shortly. Thank you for your patience.');
variable_set('site_mail', 'webguy@wwe.com');
