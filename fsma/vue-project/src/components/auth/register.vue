<!--Register-->
<template>
  <!--Contendra el contenido del componente-->
  <div class=" app-body register">
    <!--Titulo-->
    <h1 class="title">{{$t('Register.Title')}}</h1>
    <!--Formulario para inscribirse en la pagina web-->
    <form action class="form" @submit.prevent="register">
      <!--Pasar el correo electronico-->
      <label class="form-label" for="#email">{{$t('Register.Email')}}:</label>
      <input
        v-model="email"
        class="form-input"
        type="email"
        id="email"
        required
        :placeholder="$t('Register.Email')"
      />
      <!--Si el correo electronico no es valido-->
      <p v-if="error_email" class="error">
        {{ $t('Register.Error_Email') }}
      </p>
      <!---->
      <p v-if="error_exist_user" class="error">
        {{ $t('Register.Error_User_Exist') }}
      </p>
      <!--Pasar en nombre del usuario-->
      <label class="form-label" for="#email">{{$t('Register.Username')}}:</label>
      <input
        v-model="username"
        class="form-input"
        type="text"
        id="username"
        :placeholder="$t('Register.Username')"
      />
      <!--Si el nombre del usuario esta vacio-->
      <p v-if="error_username" class="error">
        {{ $t('Register.Error_Username') }}
      </p>
      <!--Pasar una contraseña-->
      <label class="form-label" for="#password">{{$t('Register.Password')}}:</label>
      <input
        v-model="password"
        class="form-input"
        type="password"
        id="password"
        :placeholder="$t('Register.Password')"
      />
      <!--Si alguna de las Contraseña esta vacia-->
      <p v-if="error_pass_empty" class="error">
        {{ $t('Register.Error_Pass_Empty') }}
      </p>
      <!--Para repetir la contraseña-->
      <label class="form-label" for="#password-repeat">
        {{ $t('Register.Repeat_Password') }}:
      </label>
      <input
        v-model="passwordRepeat"
        class="form-input"
        type="password"
        id="password-repeat"
        :placeholder="$t('Register.Repeat_Password')"
      />
      <p v-if="error_pass_no_equals" class="error">
        {{ $t('Register.Error_Pass_No_Equals') }}
      </p>
      <!--Para seleccionar el avatar-->
      <label class="form-label" for="#password-repeat">
        {{ $t('Register.Select_Avatar') }}:
      </label>
      <div class="d-flex">
        <div class="text-center" v-for="indice in 5" :key="indice">
          <img class="mb-1" :src="'./images/avatars/'+indice+'.png'"/>
          <input v-model="image" class="form-check-input"  name="avatar" :id="indice+'.png'" :value="indice+'.png'" type="radio"/>
        </div>
      </div>
      <!--Si no se ha seleccionado el avatar-->
      <p v-if="error_no_selected_avatar" class="error">
        {{ $t('Register.Error_No_Selected_Avatar') }}
      </p>
      <!--Para enviar el formulario-->
      <input class="form-submit" type="submit" value="Sign Up" />
    </form>
  </div>
</template>
  
<script>
import { crearUsuario } from '../services/BDService.js'
export default {
  data: () => ({
    email: "",
    username: "",
    password: "",
    passwordRepeat: "",
    image: "",
    error_email: false,
    error_username: false,
    error_pass_no_equals: false,
    error_pass_empty: false,
    error_no_selected_avatar: false,
    error_exist_user: false
  }),
  methods: {
    //Metodo para hacer el registro
    async register() {
      try {
        //Valida el email
        if(!this.validateEmail()){
          this.error_email = true
          return
        }
        this.error_email = false
        //Valida el nombre del usuario
        if(this.username === ''){
          this.error_username = true
          return
        }
        this.error_username = false
        //Valida la contraseña
        if(this.password ==  '' || this.passwordRepeat ==  ''){
          this.error_pass_empty = true;
          return
        }
        this.error_pass_empty = false;
        if (this.password !== this.passwordRepeat) {
          this.error_pass_no_equals = true;
          return
        }
        this.error_pass_no_equals = false;
        //Valida si esta seleccionado algun avatar
        if(this.image == ''){
          this.error_no_selected_avatar = true
          return
        }
        this.error_no_selected_avatar = false
        console.log(this.image);
        let userCreated = await crearUsuario(this.email,this.username,this.password,this.image,window.navigator.language,"ES")
        //En caso que el usuario no se creara 
        if (!userCreated)
          throw new Error();
        //Guarda el usuario
        this.error_exist_user = false;
        let user = {
          "email": this.email,
          "username": this.username,
          "password": this.password,
          "image": this.image,
          "language": window.navigator.language,
          "region": "ES"
        }
        this.$user.value = user
        if(!localStorage.login){
          localStorage.dateLogin = new Date();
          this.setCookie("timeLogin",true,1)
          localStorage.login = true
          localStorage.user = this.$user.value.email
          localStorage.pass = btoa(this.$user.value.password)
        }
        this.$i18n.locale = window.navigator.language
        this.$router.push("/");
      } catch (error) {
        //Al producirse el erro es porque el gmail ya existe
        console.log(error);
        this.error_exist_user = true;
      }
      //Almacenar el usuario
    },
    setCookie(cName, cValue, expDays) {
      let date = new Date();
      date.setTime(date.getTime() + (expDays * 24 * 60 * 60 * 1000));
      const expires = "expires=" + date.toUTCString();
      localStorage.dateExpired = date.getTime();
      document.cookie = cName + "=" + cValue + "; " + expires + "; path=/";
    },
    //Validar email
    validateEmail(){
      if(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(this.email))
        return true
      return false
    }
  }
};
</script>
  
<style lang="scss" scoped>
.title {
  text-align: center;
}
.form {
  margin: auto;
  display: flex;
  flex-direction: column;
  justify-content: center;
  width: 20%;
  min-width: 350px;
  max-width: 100%;
  background: rgba(19, 35, 47, 0.9);
  border-radius: 5px;
  padding: 40px;
  box-shadow: 0 4px 10px 4px rgba(0, 0, 0, 0.3);
}
.form-label {
  margin-top: 2rem;
  color: white;
  margin-bottom: 0.5rem;
  &:first-of-type {
    margin-top: 0rem;
  }
}
.form-input {
  padding: 10px 15px;
  background: none;
  background-image: none;
  border: 1px solid white;
  color: white;
  &:focus {
    outline: 0;
    border-color: #1ab188;
  }
}
.form-submit {
  background: #1ab188;
  border: none;
  color: white;
  margin-top: 3rem;
  padding: 1rem 0;
  cursor: pointer;
  transition: background 0.2s;
  &:hover {
    background: #0b9185;
  }
}
.error {
  margin: 1rem 0 0;
  color: #ff4a96;
}
</style>