<?php

  class RoomBedModel{
    private $conexion;    
    private $response;

    public function __CONSTRUCT(){
      $this->conexion = new Conexion();
      $this->pdo 		= $this->conexion->getConexion();
      $this->fpdo		= $this->conexion->getFluent();
      $this->response = new Response();
    }
    
    public function getAll(){
      /* 1. consulta with FluentPDO */
      $conex = $this->pdo;
      $sql = 'SELECT * FROM view_room_bed';
      $query = $conex->prepare($sql);
      $query->execute();
      $result = array();
      /* 2. encriptar IDs */
      if($query->rowCount()!=0){
        $elements = $query->fetchAll(PDO::FETCH_OBJ);
        $last = -1;
        $index = -1;
        foreach ($elements as $key => $value) {
          if($last != $value->id_room){
            $last = $value->id_room;
            $index++;
            $result[$index]['beds'] = array();  
          }
          $result[$index]['id_room'] = $value->id_room;
          $result[$index]['room_label'] = $value->room_label;
          array_push($result[$index]['beds'], array("id_bed"=>$value->id_bed, "bed_label"=>$value->bed_label));
        }
        echo json_encode($result);
      }else{
        echo 'no existe nada xd';
      }
    }

    // public function getId($id){
    //   /* 1. consulta with FluentPDO */
    //   $query = $this->fpdo->from($this->table)->where('id_nurse',$id)->execute();
    //   $result = null;
    //   /* 2. encriptar IDs */
    //   if($query->rowCount()!=0){
    //     $result = $query->fetchObject();
    //     $status = true;
    //     $msg = "Encontrado con éxito";
    //   }
    //   else{
    //     $result = array();
    //     $status = false;
    //     $msg = "No se encontro ningun resultado";
    //   }
    //   /* 3. retornar valores en un array */
    //   return $this->response->send(
    //     $result,
    //     $status,
    //     $msg,
    //     []
    //   );
    // }

    // public function add($data){
    //   /* 1 Realizamos la conexion */
    //   $conex = $this->pdo;
    //   $sql = 'CALL insertNurse(?,?,?,?,?)';
    //   $query = $conex->prepare($sql);
    //   $query->execute(
    //     array(
    //       $data->rfid,
    //       $data->first_name,
    //       $data->last_name,
    //       $data->ci,
    //       $data->cellphone
    //     )
    //   );
    //   $objR = $query->fetchObject();
    //   if($objR->failed){
    //     $result = $objR->idInsert;
    //     $message = $objR->msg;
    //     $status = true;
    //   }else{
    //     $result = -1;
    //     $message = $objR->msg;
    //     $status = false;
    //   }

    //   return $this->response->send(
    //     $result,
    //     $status,
    //     $message,
    //     []
    //   );
    // }
    
  }

?>