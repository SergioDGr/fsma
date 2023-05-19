package com.fsma.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fsma.model.User;
import com.fsma.service.IUserService;

import org.springframework.web.bind.annotation.RequestBody;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;


@Tag(description = "Controlador DB", name = "Para peticiones a la base de datos")
//Configuracion para vue
@CrossOrigin(origins = "http://localhost/", allowedHeaders = "*" )
@RestController
public class ControladorDB {
	
	/** VARIABLES */
	@Autowired
	private IUserService userService;
	//private UserRepository userRepository;
	/** GET */
	
	//GET 
	@GetMapping(value = "/suarios", produces = { "application/json" })
	@Operation(summary = "Usuarios", description = "Devuelve todos los usuarios de la bd")
	@ApiResponse(responseCode = "200", description = "Personas encontradas")
	@ApiResponse(responseCode = "400", description = "Petición inválida")
	@ApiResponse(responseCode = "404", description = "Personas no encontradas")
	
	public ResponseEntity<List<User>> dameTodasPersonas() {
		return new ResponseEntity<>(userService.dameUsuarios(), HttpStatus.OK);		
	}
	
	
	@GetMapping(value = "/login/{email}&{password}", produces = { "application/json" })
	@Operation(summary = "dameUsuarios", description = "dameUsuarios")
	@ApiResponse(responseCode = "200", description = "Personas encontradas")
	@ApiResponse(responseCode = "400", description = "Petición inválida")
	@ApiResponse(responseCode = "404", description = "Personas no encontradas")
	public ResponseEntity<User> valUser(@PathVariable(name = "email") String email,@PathVariable(name = "password") String password) {
		System.out.println("Email: " + email);
		System.out.println("Passwd: "+ password);
		Optional<User>usuario= userService.dameUsuarioPorCorreo(email);
		if(usuario.isPresent()) {
			
			User user = usuario.get();
			System.out.println(user.getPassword());
			if (user.getPassword().equals(password)) {

				return new ResponseEntity<>(user, HttpStatus.OK);
				
			}
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		}
		return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);				
	}
	
	/** POST */
	
	//POST
	@PostMapping(value = "/register")
	@Operation(summary = "insertarUsuario", description = "insertarUsuario")
	@ApiResponse(responseCode = "200", description = "Personas encontradas")
	@ApiResponse(responseCode = "400", description = "Petición inválida")
	@ApiResponse(responseCode = "404", description = "Personas no encontradas")
	
	public ResponseEntity<HttpStatus> insertarUsuario(@RequestBody User usuario) {
		System.out.println("Create User:" + usuario.getUsername());
		System.out.println("Imagen:" + usuario.getImage());
		try {
			userService.insertarUsuario(usuario);
			return new ResponseEntity<HttpStatus>(HttpStatus.CREATED);
		} catch (Exception e) {
			return new ResponseEntity<HttpStatus>(HttpStatus.BAD_REQUEST);
		}
			
	}
		
	/** DELETE */
	@DeleteMapping(value="/deleteUsuarios/{email}")
	@Operation(summary = "dameUsuarios", description = "dameUsuarios")
	@ApiResponse(responseCode = "200", description = "Personas encontradas")
	@ApiResponse(responseCode = "400", description = "Petición inválida")
	@ApiResponse(responseCode = "404", description = "Personas no encontradas")
	
	public ResponseEntity<HttpStatus> borrarUsuarioPorCorreo(@PathVariable(name = "email") String email) {
		try {
			userService.borrarUsuarioPorCorreo(email);
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);	
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	
		}
		
	}
	
	/** PUT */
	@PutMapping(value="/user/update/{emailUsuario}")
	@Operation(summary = "dameUsuarios", description = "dameUsuarios")
	@ApiResponse(responseCode = "200", description = "Personas encontradas")
	@ApiResponse(responseCode = "400", description = "Petición inválida")
	@ApiResponse(responseCode = "404", description = "Personas no encontradas")
	
	public ResponseEntity<User> actualizarCampoDeUsuario(@PathVariable(name = "emailUsuario") String emailUsuario, @RequestBody User usuario) {
			return userService.actualizarCampoDeUsuario(emailUsuario,usuario);	
	}
	
}
