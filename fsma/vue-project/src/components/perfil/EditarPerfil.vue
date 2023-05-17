<template>
    <!--Elemento para editar los datos del usuario-->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered ">
            <!--Formulario donde se hara la peticion-->
            <form action class="form" @submit.prevent="this.editUser"> 
                <div class="modal-content bg-dark">
                    <!--Cabezera-->
                    <div class="modal-header">
                        <!--Titulo del modal-->
                        <h1 class="modal-title fs-5" id="exampleModalLabel">{{ $t('Profile.Edit')}}</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <!--Contenido-->
                    <div class="modal-body m-3">
                        <!--Si el usuario se ha podido actualizar-->
                        <div v-if="updated" class="text-uppercase fw-bold text-success">
                            {{ $t('Prfile.Success_Update') }}
                        </div>
                        <!--Si no se ha podido actualizar-->
                        <div v-if="error_to_update" class="text-uppercase fw-bold error">
                           {{ $t('Profile.Error_Update') }}
                        </div>
                        <!--Si el usuario esta vacio-->
                        <div v-if="error_username" class="error">
                            {{ $t('Profile.Error_User') }}
                        </div>
                        <!--Usuario-->
                        <div class="mb-3">
                            <label class="form-label mt-1">{{ $t('Profile.User') }}:</label> 
                            <input v-model="username" type="text" class="form-control"/>
                        </div>
                        <!--Avatar-->
                        <div class="mb-3">
                            <label class="form-label mt-1">{{ $t('Profile.Avatar') }}: </label> 
                            <div class="d-flex">
                                <div class="text-center" v-for="indice in 5" :key="indice">
                                    <img class="mb-1" :src="path+indice+'.png'"/>
                                    <input  v-model="image" class="form-check-input"  name="avatar" :id="indice+'.png'" :value="indice+'.png'" type="radio"/>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="row">
                                <div class="col-6">
                                    <!--Idioma-->
                                    <label>{{$t('Profile.Language')}}</label>
                                    <select class="form-select" name="language" id="language" aria-label="Default select example">
                                        <option value="es" :selected="language =='es'">{{$t('Profile.Languages[0]')}}</option>
                                        <option value="en" :selected="language =='en'">{{$t('Profile.Languages[1]')}}</option>
                                    </select>
                                </div>
                                <div class="col-6">
                                    <!--Region-->
                                    <label>{{ $t('Profile.Region')}}</label>
                                    <select class="form-select" name="region" id="region" aria-label="Default select example">
                                        <option value="ES" :selected="region =='ES'">{{$t('Profile.Regions[0]')}}</option>
                                        <option value="US" :selected="region =='US'">{{$t('Profile.Regions[1]')}}</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--Contraseña nueva-->
                        <div class="mb-3">
                            <label class="form-label">{{$t('Profile.New_Password')}}: </label> 
                            <input v-model="password" type="password" class="form-control"/>
                        </div>
                        <!--Repetir la contraseña nueva-->
                        <div class="mb-3">
                            <label class="form-label">{{$t('Profile.New_Repeat_Password')}}: </label> 
                            <input v-model="passwordRepeat" type="password" class="form-control"/>
                        </div>
                        <!--Error si alguna de las constraseña esta vacia-->
                        <div v-if="error_pass_empty" class="error">
                            {{$t('Profile.Error_Password_Empty')}}
                        </div>
                        <!--Error si son identicas-->
                        <div v-if="error_pass_no_equals" class="error">
                            {{ $t('Profile.Error_Password_No_Equals') }}
                        </div>
                    </div>
                    <!--Enviar el formulario o cerrar el modal-->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <input class="form-submit btn btn-primary" type="submit" value="Save changes">
                    </div>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
import { modificarUsuario } from '../services/BDService.js'

export default {
    //Datos que se le pasa
    props:{
        path: String
    },
    //Variables del componente
    data(){
        return{
            username: this.$user.value.username,
            password: "",
            passwordRepeat: "",
            image: this.$user.value.image,
            language: this.$user.value.language,
            region: this.$user.value.region,
            error_username: false,
            error_pass_empty: false,
            error_pass_no_equals: false, 
            error_to_update: false,
            updated: false,
        }
    },
    //Metodos
    methods:{
        //Metodo que hace la peticion de modificacion al usuario
        async editUser(){
            this.updated = false;
            this.error_to_update = false;
            //Comprobar el nombre del usuario
            if(this.username == ''){
                this.error_username = true;
                return;
            }
            //comprueba las contraseñas
            if(this.password != ''){
                if (this.passwordRepeat == ''){
                    this.error_pass_empty = true;
                    this.error_pass_no_equals = false;
                    return;
                }else{
                    if(this.password !== this.passwordRepeat){
                        this.error_pass_no_equals = true;
                        this.error_pass_empty = false;
                        return;
                    }
                }
            }else{
                if (this.passwordRepeat != ''){
                    this.error_pass_empty = true;
                    this.error_pass_no_equals = false;
                    return;
                }
            }
            this.error_pass_empty = false;
            this.error_pass_no_equals = false;
            //actualizar
            let isUpdated = await modificarUsuario(this.$user.value.email,this.username,this.password,this.image,
            this.language,this.region);
            console.log(isUpdated);
            //error al actualizar
            if(!isUpdated){
                this.error_to_update = true;
                return;
            }
            //Exito al actualizar
            this.error_to_update = false;
            if(this.password != '' && this.password != this.$user.value.password)
                localStorage.pass = btoa(this.password)
            this.updated = true;
        }
    }
}
</script>

<style>
.error {
    color: #ff4a96;
}
</style>