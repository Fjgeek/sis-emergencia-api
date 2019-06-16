<?php

class Env{

  private $key = null;
  private $access = false;

  public function __CONSTRUCT($key){
    $this->key = $key;
    $this->access = $this->checkApiKey();
  }
  
  public function getUser(){
    if($this->access){
      return "goomovil";
    }else{
      return false;
    }
  }
  public function getPass(){
    if($this->access){
      return "Pq[]DlV[KHd)";
    }else{
      return false;
    }
  }
  public function getHost(){
    if($this->access){
      return "localhost";
    }else{
      return false;
    }
  }
  public function getDataBaseName(){
    if($this->access){
      return "goomovil_db";
    }else{
      return false;
    }
  }

  public function checkApiKey(){
    $security = new Security();
    $entry = $security->desencriptar($this->key);
    if(trim($entry)==="goo.#m.15.$$"){
      return true;
    }else{
      return false;
    }
    return false;
  }
}

?>
