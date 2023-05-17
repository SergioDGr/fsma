<!--Header-->
<template>
  <!--Offcanvas donde se visualiza el apartado del usuario-->
  <div v-if="this.$user.value != null" class="offcanvas offcanvas-start negro" data-bs-scroll="true" tabindex="-1" id="offcanvasWithBothOptions" aria-labelledby="offcanvasWithBothOptionsLabel">
    <div class="offcanvas-header">
      <h5 class="offcanvas-title fs-3 text-warning" id="offcanvasWithBothOptionsLabel">{{ this.$user.value.username }}</h5>
      <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <hr class="m-0">
    <div class="offcanvas-body">
      <div>
        <a class="text-decoration-none m-0 fs-5 text-light decoracionEnlace" data-bs-toggle="modal" data-bs-target="#exampleModal">EDITAR PERFIL</a>
      </div>
      <hr>
      <button @click="logOut" data-bs-dismiss="offcanvas" class="btn btn-light">Log out</button>
    </div>
   
  </div>
  <editar-perfil :path="path" v-if="this.$user.value != null"></editar-perfil>
  <!--Navegador-->
  <nav class="navbar navbar-expand-lg">
    <div class="container-fluid collapses">
      <!--Boton para desplegar el navegador para pantallas pequeñas-->
      <button class="navbar-toggler bg-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <!--El buscador para pantalla pequeñas-->
      <search-bar class="d-lg-none" :routeName="currentRouteName "></search-bar>
      <!--Contenido del navegador-->
      <div class="collapse navbar-collapse row" id="navbarNav">
        <!--El avatar del usuario si esta logeado-->
        <div v-if="this.$user.value != null" class="col-lg-1 col-12 d-flex justify-content-center" id="navbarNav">
          <a class="py-1" data-bs-toggle="offcanvas" data-bs-target="#offcanvasWithBothOptions" aria-controls="offcanvasWithBothOptions">
            <img v-if="this.$user.value.image == '1.png'" class="rounded rounded-5 border border-light border-2 imagen" :src="path+'1.png'" alt="icono">
            <img v-else-if="this.$user.value.image =='2.png'" class="rounded rounded-5 border border-light border-2 imagen" :src="path +'2.png'" alt="icono">
            <img v-else-if="this.$user.value.image =='3.png'" class="rounded rounded-5 border border-light border-2 imagen" :src="path +'3.png'" alt="icono">
            <img v-else-if="this.$user.value.image == '4.png'" class="rounded rounded-5 border border-light border-2 imagen" :src="path+'4.png'" alt="icono">
            <img v-else class="rounded rounded-5 border border-light border-2 imagen" :src="path+'5.png'" alt="icono">
          </a>
        </div>
        <div class="col-lg">
          <ul v-if="isScreenSmall" class="navbar-nav col d-flex justify-content-evenly text-center">
            <!--Si visualizara el enlace login si no esta logeado-->
            <li v-if="this.$user.value == null" class="nav-item mt-5 mt-lg-0" >
              <router-link class="nav-link active style w-100" active-class="active" to="/login" ><b>Login</b></router-link>
            </li>
            <!--Para ir al Inicio-->
            <li class="nav-item" data-bs-toggle="collapse" data-bs-target="#navbarNav">
              <router-link class="nav-link active style" active-class="active" to="/" ><b>{{ $t('Header.Home') }}</b></router-link>
            </li>
            <!--Para ir a las peliculas-->
            <li class="nav-item" data-bs-toggle="collapse" data-bs-target="#navbarNav">
              <router-link class="nav-link active style" active-class="active" to="/movie"><b>{{ $t('Header.Movies') }}</b></router-link>
            </li>
            <!--Para ir a las Series-->
            <li class="nav-item mb-5 mb-lg-0" data-bs-toggle="collapse" data-bs-target="#navbarNav">
              <router-link class="nav-link active style" active-class="active" to="/serie"><b>{{ $t('Header.Series') }}</b></router-link>
            </li>
          </ul>
          <ul v-else class="navbar-nav col d-flex justify-content-evenly text-center">
            <!--Si visualizara el enlace login si no esta logeado-->
            <li v-if="this.$user.value == null" class="nav-item w-100 mt-5 mt-lg-0">
              <router-link class="nav-link active style" active-class="active" to="/login" ><b>Login</b></router-link>
            </li>
            <!--Para ir al Inicio-->
            <li class="nav-item w-100">
              <router-link class="nav-link active style" active-class="active" to="/"><b>{{ $t('Header.Home') }}</b></router-link>
            </li>
            <!--Para ir a las peliculas-->
            <li class="nav-item w-100">
              <router-link class="nav-link active style" active-class="active" to="/movie"><b>{{ $t('Header.Movies') }}</b></router-link>
            </li>
            <!--Para ir a las Series-->
            <li class="nav-item w-100 mb-5 mb-lg-0">
              <router-link class="nav-link active style" active-class="active" to="/serie"><b>{{ $t('Header.Series') }}</b></router-link>
            </li>
            <!--Para buscar series o peliculas-->
            <li class="nav-item w-100 d-none d-lg-block">
                <search-bar :routeName="currentRouteName "></search-bar>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </nav>
</template>

<script >
  import searchBar from '../search/search-bar.vue';
  import editarPerfil from '../perfil/EditarPerfil.vue';
  export default{
    data(){
      return{
        isVisibleEditarPerfil: false,
        path: '../images/avatars/',
        isScreenSmall: !window.matchMedia("(min-width: 992px)").matches
      }
    },
    //Guarda la routa actual
    props:{
      currentRouteName: String
    },
    //Componentes que utiliza el Header 
    components:{
      searchBar: searchBar,
      editarPerfil: editarPerfil
    },
    methods:{
      //Para salir de sesion
      logOut(){
        this.$user.value = null
        localStorage.clear();
        this.$router.push("/");
        this.setCookie("timeLogin",false,0);
      },
      //Para quitar la cookie
      setCookie(cName, cValue, expDays) {
        let date = new Date();
        date.setTime(date.getTime() + (expDays * 24 * 60 * 60 * 1000));
        const expires = "expires=" + date.toUTCString();
        document.cookie = cName + "=" + cValue + "; " + expires + "; path=/";
      },
      changeScreen(){
        this.isScreenSmall = !window.matchMedia("(min-width: 992px)").matches
      }
    },
    created(){
      window.addEventListener('resize',this.changeScreen)
    }
  }
</script>

<style scoped>
  .style{
    text-decoration: none;
  }
  img{
    width: 10rem;
    height: 3rem;
  }
  .navbar{
    position: fixed;
    width: 100%;
    height: 4.5rem;
    z-index: 10;
    top: 0;
    background: rgb(24, 24, 24);
    border-bottom: #333333 solid 1px;
  }
  .nav-link{
    color: #fff !important;
  }
  .style{
    text-decoration: none;
  }
  .negro{
    height: 100%;
    left: 0;
    top: 4.5rem;
    background: rgb(63, 63, 63);
    font-family: 'Montserrat', sans-serif;
  }
  .offcanvas{
    width: 15% !important;
    min-width: 17.5rem !important;
  }
  .nav-link:hover{
    color: rgb(250, 250, 250) !important;
    background-color: #494949;
  }
  .router-link-exact-active{
    color: rgb(232, 255, 25) !important;
    background-color: #333333;
  }
  li{
    font-size: 1.1rem;
  }
  .collapses{
    background: rgb(24, 24, 24);
  }

  @media (min-width: 992px){
    .imagen{
      width: 90% !important;
    }
  }

  @media (min-width: 1300px){
    .imagen{
      width: 50% !important;
    }
  }
  .imagen{
    width: 20%;
    height: 100%;
    margin:auto;
    display: flex;
  }

  .decoracionEnlace:hover{
    color: lightskyblue !important;
    font-weight: bold;
  }

</style>

