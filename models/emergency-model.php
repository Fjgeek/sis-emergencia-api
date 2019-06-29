<?php
  class EmergencyModel{
    private $conexion;
    private $table = 'emergency';
    private $response;

    public function __CONSTRUCT(){
      $this->conexion = new Conexion();
      $this->pdo 		= $this->conexion->getConexion();
      $this->fpdo		= $this->conexion->getFluent();
      $this->response = new Response();
    }
    
    public function requestEmergency($id_bed){
      $where = array(
        "bed_id"=>$id_bed,
        "enabled"=> new FluentLiteral("1")
      );
      $queryEmergency = $this->fpdo->from('emergency')->where($where)->orderBy('id_emergency DESC')->limit(1)->execute();
      // Verificamos si ya se registro una emergencia de la misma cama
      if($queryEmergency->rowCount() == 0){
        $queryRoomBed = $this->fpdo->from('room_bed')->where('bed_id',$id_bed)->limit(1)->execute();
        // Verificarmos que la cama exista
        if($queryRoomBed->rowCount() != 0){
          // Registramos la emergencia
          $roomBed = $queryRoomBed->fetchObject();
          $values = array(
            "room_id"=> $roomBed->room_id,
            "bed_id"=> $roomBed->bed_id,
            "time_request"=> new FluentLiteral("CURRENT_TIME"),
            "created"=> new FluentLiteral("CURRENT_TIMESTAMP"),
            "enabled"=> new FluentLiteral("1")
          );
          $query = $this->fpdo->insertInto($this->table)->values($values);
          $idInsert = $query->execute();
          var_dump($idInsert);
          $result = array(
            "id_emergency"=> $idInsert
          );
          $msg = "Emergencia solicitada con exito";
          $status = true;
        }else{
          // La cama no esta registrada o asociada a una sala
          $result = null;
          $msg = "La cama no esta registrada";
          $status = false;
        }
      }else{
        // Ya existe una emergencia registrada para esta cama
        $emergency = $queryEmergency->fetchObject();
        $result = array(
          "id_emergency"=> $emergency->id_emergency
        );
        $msg = "Ya se solicito atención";
        $status = true;
      }
      // Respuesta
      return $this->response->send(
        $result,
        $status,
        $msg,
        []
      );
    }

    public function emergencyNow(){
      $where = array(
        "enabled"=> new FluentLiteral("1")
      );
      $query = $this->fpdo->from($this->table)->where($where)->execute();
      if($query->rowCount()!=0){
        $result = $query->fetchAll(PDO::FETCH_OBJ);
        $status = true;
        $msg = "Se encontraron ".count($result)." solicitudes";
      }else{
        $result = null;
        $status = false;
        $msg = "No hay solicitudes";
      }
      // Respuesta
      return $this->response->send(
        $result,
        $status,
        $msg,
        []
      );
    }

    public function emergencyNowDetail(){
      $query = $this->fpdo->from('view_emergency_now_detail')->execute();
      if($query->rowCount()!=0){
        $result = $query->fetchAll(PDO::FETCH_OBJ);
        $status = true;
        $msg = "Se encontraron ".count($result)." solicitudes";
      }else{
        $result = null;
        $status = false;
        $msg = "No hay solicitudes";
      }
      // Respuesta
      return $this->response->send(
        $result,
        $status,
        $msg,
        []
      );
    }
    
  }

?>