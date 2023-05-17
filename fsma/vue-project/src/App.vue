<!--Aplicacion-->
<template>
    <!--Header-->
    <nav-bar :currentRouteName="this.$route.name"></nav-bar>
    <!--Visuliza el contenido del media dependiendo de la routa-->
    <!--Si la routa es Serie o Pelis Tienen un identificador-->
    <div v-if="$route.name == 'Movie' || $route.name == 'Serie'" >
      <router-view :key="$route.path"></router-view>
    </div>
    <div v-else>
      <router-view ></router-view>
    </div>
    <!--Visualiza el footer si las paginas no sean login o register-->
    <footer-bar v-if="$route.name!='Register' && $route.name!='Login' "></footer-bar>
</template>

<script>
import NavBar from "./components/template/Header.vue"
import FooterBar from './components/template/Footer.vue'
import { validarUser } from "./components/services/BDService.js" 
import { useI18n } from 'vue-i18n';

export default{
  //Componente que se añaden
  components:{
    NavBar,
    FooterBar
  },
  //Antes que se cree mira si el usuario esta logeado o no
  async beforeCreate(){
    let date = new Date().getTime();
    let expiredDate
    if (localStorage.dateExpired){
      console.log("Fecha: ");
      console.log(date);
      expiredDate = localStorage.dateExpired;
      console.log("Fecha expiracion:")
      console.log(expiredDate);
      if(expiredDate <= date){
        localStorage.clear();
        this.$user.value = null;
      }
    }
    if (localStorage.login){
      let pass = atob(localStorage.pass)
      this.$user.value = await validarUser(localStorage.user,pass)
      this.$i18n.locale = this.$user.value.language
    }else{
      this.$i18n.locale = window.navigator.language.substring(0,2)
    }

    //this.$user.value = {username:'jesulin de ubrique',image:'2.png'}
  },
  //para utilizar los idiomas
  setup(){
      const { t } = useI18n()
      return{ t }
  }
}
</script>