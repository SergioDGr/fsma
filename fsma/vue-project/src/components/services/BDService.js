import axios  from "axios";
import { BD_PATH } from "../../config/env";
//Consulta para validar el usuario y que pasa la informacion
export async function validarUser(email,pass){
    let user = null;
    await axios.get(BD_PATH +"login/"+email+"&"+pass)
    .then(response => {
        console.log(response);
        if(response.status === 200){
            user = response.data;
            console.log(user);
        }else
            console.log(response.statusText);
    }).catch(e => {
        console.log(e);
    })
    return user;

}
//Consulta para creal el usuario
export async function crearUsuario(email,username,passwd,image,lang,region){
    let isUserCreated;
    await axios.post(BD_PATH +"register",{
        email: email,
        username: username,
        password: passwd,
        image: image,
        language: lang,
        region: region
    })
    .then(response => {
        console.log(response);
        isUserCreated = true;
    }).catch(e => {
        console.log(e);
        isUserCreated = false
    })
    return isUserCreated;
}
//Para modificar el usuario
export async function modificarUsuario(email,username,passwd,image,lang,region){
    let isUpdatedUser
    await axios.put(BD_PATH+"user/update/"+email,{
        username: username,
        password: passwd,
        image: image,
        language: lang,
        region: region
    }).then(response => {
        console.log(response);
        isUpdatedUser = true;
    }).catch(e =>{
        console.log(e);
        isUpdatedUser = false
    })
    return isUpdatedUser;
}