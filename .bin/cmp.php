#!/usr/bin/php
<?php

$metrics = explode(',', $argv[1]);

foreach ($metrics as $metric) {
    echo sprintf("%-4s %'*50s\n", $metric, "");
    
    $difference = "";
    
    $diff = str_replace(".png", "-diff.png", $argv[2]);
    $compare = "compare -fuzz 5% -metric $metric $argv[2] $argv[3] $diff 2>&1";
    
    ob_start();
    $ret = system($compare, $retval);
    ob_end_clean();
    
    if ($retval == 0) {
        $arr = explode(' ', $ret);
        if (count($arr) == 2) {
            $difference = trim($arr[count($arr)-1], "()") * 100;
        }
    }
    
    if ($metric == "AE") {
        $identify = "identify -format \"%w %h\" $argv[2]";
        ob_start();
        $ret_i = system($identify, $retval_i);
        ob_end_clean();
        $dimen = explode(' ', $ret_i);
        $px_total = (0.0+$dimen[0]) * (0.0+$dimen[1]);
        $difference = $ret / $px_total * 100.0;
    }
    
    echo sprintf("Output: %s\n", $ret);
    if ($difference !== "") {
        echo sprintf("Difference = %2.2f%%\n", $difference);
    }
    echo sprintf("Return: %3d\n\n", $retval);
}

echo "diff imag output to $diff\n" . PHP_EOL;
exit(0);




if ($retval_ae == 0) {
    // An AE difference
    $dimen = explode(' ', $ret_i);
    $px_total = (0.0+$dimen[0])*(0.0+$dimen[1]);
   
    $difference = $ret_ae / $px_total * 100.0;
    echo "[AE] The images ";
    if ($difference <= 5.0) {
        echo "DO ";
    }
    else {
        echo "do NOT ";
    }
    echo "match ($difference%)\n";
    echo "************************************************" . PHP_EOL;
}




?>
