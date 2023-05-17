<!--Login-->
<template>
  <!--Contendra el contenido del componente-->
  <div class="app-body login">
    <!--Titulo-->
    <h1 class="title">{{ $t('Login.Title')}}</h1>
    <!--Formulario para logearse en la pagina web-->
    <form action class="form" @submit.prevent="this.login">
      <!--Pasar el correo electronico-->
      <label class="form-label" for="#email">{{ $t('Login.Email')}}:</label>
      <input
        v-model="email"
        class="form-input"
        type="email"
        id="email"
        required
        :placeholder="$t('Login.Email')"
      />
      <!--Si el correo electronico no es valido-->
      <p v-if="error_email"  class="error mb-0 mt-3">
        {{ $t('Login.Error_Email') }}
      </p>
      <!--Pasar la contraseña del correo electronico-->
      <label class="form-label" for="#password">{{$t('Login.Password')}}:</label>
      <input
        v-model="password"
        class="form-input"
        type="password"
        id="password"
        :placeholder="$t('Login.Password')"
      />
      <!--Contraseña esta vacia-->
      <p v-if="error_pass" class="error mb-0 mt-3">
        {{ $t('Login.Error_Password') }}
      </p>
      <!--Si alguno de los datos no es correcto-->
      <p v-if="error_auth" class="error mb-0 mt-3">
        {{ $t('Login.Error_Auth') }}
      </p>
      <!--Para enviar el formulario-->
      <input class="form-submit" type="submit" :value="$t('Login.Login')" />
    </form>
    <!--En caso que no tenga cuenta-->
    <p class="msg">
      {{ $t('Login.No_Account') }}
      <router-link to="/register">{{$t('Login.Register')}}</router-link>
    </p>
  </div>
</template>
  
<script>
import { validarUser } from "../services/BDService.js" 

export default {
  data: () => ({
    email: "",
    password: "",
    error_auth: false,
    error_email: false,
    error_pass: false
  }),
  methods: {
    //Para logearse en pagina web
    async login() {
      try {
        //Validar email
        if(!this.validateEmail()){
          this.error_email = true
          return;
        }
        this.error_email = false
        //Validar la contraseña
        if(this.password == ''){
          this.error_pass = true
          return;
        }
        this.error_pass = false
        //consulta para conseguir el usuario
        const user = await validarUser(this.email,this.password)
        //para validar usuario
        if (user == null){
          throw new Error()
        }
        this.error_auth = false
        //Guardar usuario
        this.$user.value = user
        if(!localStorage.login){
          localStorage.dateLogin = new Date();
          this.setCookie("timeLogin",true,1)
          localStorage.login = true
          localStorage.user = this.$user.value.email
          localStorage.pass = btoa(this.$user.value.password)
        }
        console.log(this.$user.value);
        this.$i18n.locale = this.$user.value.language
        this.$router.push("/");
      } catch (error) {
        //En caso de que usuario no es valido
        this.error_auth = true;
      }
    },
    //Para poner la Cookie
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
  color: #ff4a96;
}
.msg {
  margin-top: 3rem;
  text-align: center;
}
</style>