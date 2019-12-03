<?php
  class BedModel{
    private $conexion;
    private $table = 'bed';
    private $response;

    public function __CONSTRUCT(){
      $this->conexion = new Conexion();
      $this->pdo 		= $this->conexion->getConexion();
      $this->fpdo		= $this->conexion->getFluent();
      $this->response = new Response();
    }
    
    public function updatePriority($data){
      /* 1 Realizamos la conexion */
      $idBed = intval($data->id_bed);
      $idRoom = intval($data->id_room);
      $priority = intval($data->priority);
      $values = array(
        "priority"=> $priority,
      );
      $result = null;
      $message = 'Actualizado con exito';
      $queryUpdate = $this->fpdo->update($this->table)->set($values)->where('id_bed', $idBed)->execute();
      if($priority === 0){
        $queryEmergency = $this->fpdo->from('emergency')->where('room_id = '.$idRoom.' AND bed_id = '.$idBed.' AND enabled='.new FluentLiteral("1"))->orderBy('id_emergency DESC')->execute();
        if($queryEmergency->rowCount() != 0){
          $result = $queryEmergency->fetchObject();
          $queryDelete = $this->fpdo->delete('emergency')->where('id_emergency = '.intval($result->id_emergency));
          $queryDelete->execute();
          $message = "Actualizado y se elimino emergencia";
        }
      }
      
      $status = true;

      return $this->response->send(
        $result,
        $status,
        $message,
        []
      );
    }

  }

?>