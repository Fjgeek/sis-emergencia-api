<?php
	session_start();

	require 'vendor/autoload.php';

	\Slim\Slim::registerAutoloader();

	$app = new \Slim\Slim();

	$corsOptions = array(
    "origin" => "*",
    "exposeHeaders" => array("Content-Type", "X-Requested-With", "X-authentication", "X-client"),
    "allowMethods" => array('GET', 'POST', 'PUT', 'DELETE', 'OPTIONS')
	);
	$app->add(new \CorsSlim\CorsSlim($corsOptions));


  /* security */
	require "common/security.php";
  /* enviroment */
  require "env/env.dev.php";

	/* Common */
	require "common/conexion.php";
  	require "common/response.php";
  	require "common/verify-captcha.php";
	require "common/image-resizer.php";

	/* Models */
	
	/* Routes */
	
	/* Hello World */
	$app->get('/', function(){
		echo 'Funciona Correctamente';
	});

	$app->run();
