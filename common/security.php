<?php

class Security{
	private $api_key = 't@AchEyem5Se.jjgsl';

	public function encriptar($string)
	{
		$key='042c76ee72648fd8c1841340da5b6da2';
		$td = mcrypt_module_open(MCRYPT_RIJNDAEL_128, '', MCRYPT_MODE_CBC, '');
		$iv = mcrypt_create_iv(mcrypt_enc_get_iv_size($td), MCRYPT_DEV_URANDOM );
		mcrypt_generic_init($td, $key, $iv);
		$encrypted_data_bin = mcrypt_generic($td, $string);
		mcrypt_generic_deinit($td);
		mcrypt_module_close($td);
		$encrypted_data_hex = bin2hex($iv).bin2hex($encrypted_data_bin);
		return $encrypted_data_hex;
	}

	public function desencriptar($encrypted_data_hex)
	{
		$key='042c76ee72648fd8c1841340da5b6da2';
		$td = mcrypt_module_open(MCRYPT_RIJNDAEL_128, '', MCRYPT_MODE_CBC, '');
		$iv_size_hex = mcrypt_enc_get_iv_size($td)*2;
		$iv = pack("H*", substr($encrypted_data_hex, 0, $iv_size_hex));
		$encrypted_data_bin = pack("H*", substr($encrypted_data_hex, $iv_size_hex));
		mcrypt_generic_init($td, $key, $iv);
		$decrypted = mdecrypt_generic($td, $encrypted_data_bin);
		mcrypt_generic_deinit($td);
		mcrypt_module_close($td);
		return $decrypted;
	}
	public function hidePassword($data){
		$salt = '#/$02.06$/#_#/$25.10$/#';
		$data = md5($salt.$data);
		$newdata = sha1($salt.$data);
		return $newdata;
	}
	public function checkCode($key){
		if(trim($this->desencriptar($key)) == $this->api_key){
			return true;
		}else{
			return false;
		}

	}
}
?>