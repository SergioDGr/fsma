package com.fsma.service;

import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;

import com.fsma.model.User;

public interface IUserService {

	List<User> dameUsuarios();
	Optional<User> dameUsuarioPorCorreo(String email);
	void insertarUsuario(User usuario) throws Exception;
	void borrarUsuarioPorCorreo(String email);
	ResponseEntity<User> actualizarCampoDeUsuario(String emailUsuario, User parametro);
}
