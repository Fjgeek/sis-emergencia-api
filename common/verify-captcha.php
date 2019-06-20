<?php
  
  function checkCaptcha($recaptcha){
    $url = 'https://www.google.com/recaptcha/api/siteverify';
    $data = array(
      'secret' => '6LeC6GoUAAAAANEF-1hoFG8BoqX_fJEKHIX-GaWE',
      'response' => $recaptcha
    );
    $query = http_build_query($data);
    $options = array(
      'http' => array (
        'header'=> "Content-Type: application/x-www-form-urlencoded\r\n".
                  "Content-Length: ".strlen($query)."\r\n".
                  "User-Agent:MyAgent/1.0\r\n",
        'method' => 'POST',
        'content' => $query
      )
    );
    $context  = stream_context_create($options);
    $verify = file_get_contents($url, false, $context,-1,4000);
    $captcha_success = json_decode($verify);
    if ($captcha_success->success) {
      // No eres un robot, continuamos con el envío del email
      return true;
    } else {
      // Eres un robot!
      return false;
    }
  }
?>