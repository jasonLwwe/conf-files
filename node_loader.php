<?php

require_once '/u01/www/wwe3redesign/tests/bootstrap.php';

use Migration\config\DBManager;

$nid = $_SERVER['argv'][1];

$node = node_load($nid);

if (!$node) {
  print("Node $nid does not exist.\n");
  exit();
}

$conn = DBManager::getTargetConnection();

$s = $conn->prepare(
"SELECT translatable
FROM field_config
WHERE field_name = :field");

foreach ($node as $field => $value) {
  $s->execute(array(':field' => $field));
  $results = $s->fetchAll(PDO::FETCH_OBJ);
  foreach ($results as $result) { 
    if (isset($result->translatable) && $result->translatable == 1) {
      switch ($field) {
        case 'field_talent_from':
        case 'field_talent_height':
        case 'field_talent_signature_move':
        case 'field_talent_weight':
        case 'field_talent_career_highlights':
        case 'body':
          printf("%'*80s\n", $field);
          foreach ($value as $language => $translation) {
            print("$language: {$translation[0]['value']}\n" );
          }
      }
    }
  }
  
}
