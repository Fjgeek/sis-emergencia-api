<?php
	session_start();

	require 'vendor/autoload.php';

	\Slim\Slim::registerAutoloader();

	$app = new \Slim\Slim();

	// $corsOptions = array(
    // 	"origin" => "*",
    // 	"exposeHeaders" => array(
	// 		"X-API-KEY", "Origin", "X-Requested-With" , "Authorization" ,"Content-Type", "Accept", "Access-Control-Request-Method", "x-xsrf-token"
	// 	),
	// 	"maxAge" => 1728000,
    // 	"allowCredentials" => True,
	// 	"allowMethods" => array('GET', 'POST', 'PUT', 'DELETE', 'OPTIONS')
	// );
	// $app->add(new \CorsSlim\CorsSlim($corsOptions));



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

	$app->get('/peticion/:id', function($id){
		echo 'Funciona Correctamente '.$id;
	});

	$app->run();
