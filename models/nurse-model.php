<?php
  class NurseModel{
    private $conexion;
    private $table = 'nurse';
    private $response;

    public function __CONSTRUCT(){
      $this->conexion = new Conexion();
      $this->pdo 		= $this->conexion->getConexion();
      $this->fpdo		= $this->conexion->getFluent();
      $this->response = new Response();
    }
    
    public function getAll(){
      /* 1. consulta with FluentPDO */
      $query = $this->fpdo->from($this->table)->orderBy('id_nurse DESC')->execute();
      $result = null;
      /* 2. encriptar IDs */
      if($query->rowCount()!=0){
        $result = $query->fetchAll(PDO::FETCH_OBJ);
        $status = true;
        $msg = "Lista de enfermeras habilitadas";
      }
      else{
        $result = array();
        $status = false;
        $msg = "No existen registros";
      }
      /* 3. retornar valores en un array Response */
      return $this->response->send(
        $result,
        $status,
        $msg,
        []
      );
    }

    public function getId($id){
      /* 1. consulta with FluentPDO */
      $query = $this->fpdo->from($this->table)->where('id_nurse',$id)->execute();
      $result = null;
      /* 2. encriptar IDs */
      if($query->rowCount()!=0){
        $result = $query->fetchObject();
        $status = true;
        $msg = "Encontrado con éxito";
      }
      else{
        $result = array();
        $status = false;
        $msg = "No se encontro ningun resultado";
      }
      /* 3. retornar valores en un array */
      return $this->response->send(
        $result,
        $status,
        $msg,
        []
      );
    }

    public function add($data){
      /* 1 Realizamos la conexion */
      $conex = $this->pdo;
      $sql = 'CALL insertNurse(?,?,?,?,?)';
      $query = $conex->prepare($sql);
      $query->execute(
        array(
          $data->rfid,
          $data->first_name,
          $data->last_name,
          $data->ci,
          $data->cellphone
        )
      );
      $objR = $query->fetchObject();
      if($objR->failed){
        $result = $objR->idInsert;
        $message = $objR->msg;
        $status = true;
      }else{
        $result = -1;
        $message = $objR->msg;
        $status = false;
      }

      return $this->response->send(
        $result,
        $status,
        $message,
        []
      );
    }
  }
?>