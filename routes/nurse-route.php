<?php
  $app->get('/nurse/all', function() use($app){
    $app->response->headers->set('Content-type','application/json');
    $app->response->headers->set('Access-Control-Allow-Origin','*');
    $obj = new NurseModel();
    try {
      $obj = new NurseModel();
      $app->response->status(200);
      $app->response->body(json_encode( $obj->getAll() ));
    }catch(PDOException $e) {
      $app->response->status(500);
      $app->response->body(json_encode( array('result'=>[],'status'=>false,'message'=>$e->getMessage(),'error'=>'500') ));
    }
  });
?>