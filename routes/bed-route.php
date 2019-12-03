<?php
    $app->post('/bed/update/priority', function() use($app){
        $app->response->headers->set('Content-type','application/json');
        $app->response->headers->set('Access-Control-Allow-Origin','*');
        try {
          $objDatos = json_decode(file_get_contents("php://input"));
          $obj = new BedModel();
          $app->response->status(200);
          $app->response->body(json_encode( $obj->updatePriority($objDatos) ));
        }catch(PDOException $e) {
          $app->response->status(500);
          $app->response->body(json_encode( array('result'=>[],'status'=>false,'message'=>$e->getMessage(),'error'=>'500') ));
        }
      });
?>