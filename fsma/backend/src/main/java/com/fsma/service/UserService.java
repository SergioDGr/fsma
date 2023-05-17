package com.fsma.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.fsma.model.User;
import com.fsma.repository.UserRepository;


@Service
public class UserService implements IUserService{
	
	@Autowired
	private UserRepository userRepository;
	@Override
	public List<User> dameUsuarios() {
		try {
			return userRepository.findAll();
		}catch(Exception e) {
			
		}
		return null;
	}
	
	@Override
	public void insertarUsuario(User usuario) throws Exception{
			Optional<User> user = userRepository.findById(usuario.getEmail());
			if(!user.isPresent())
				userRepository.save(usuario);
			else
				throw new Exception("El usuario existe");
	}
	
	@Override
	public Optional<User> dameUsuarioPorCorreo(String email) {
		try {
			System.out.println("Service: email = " + email);
			return userRepository.findById(email);			 
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	@Override
	public void borrarUsuarioPorCorreo(String email) {
		try {
			userRepository.deleteById(email);
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
	}

	@Override
	public ResponseEntity<User> actualizarCampoDeUsuario(String emailUsuario, User parametro) {
		Optional<User> usu = dameUsuarioPorCorreo(emailUsuario);
		if(usu.isPresent()) {
			User usuario = usu.get();
			if(parametro.getUsername() != "")
				usuario.setUsername(parametro.getUsername());
			if(parametro.getPassword() != "")
				usuario.setPassword(parametro.getPassword());
			if (parametro.getImage() != "")
				usuario.setImage(parametro.getImage());
			if (parametro.getLanguage() != "")
				usuario.setLanguage(parametro.getLanguage());
			if(parametro.getRegion() != "")
				usuario.setRegion(parametro.getRegion());
			return new ResponseEntity<>(userRepository.save(usuario), HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
	}


	
	
}
