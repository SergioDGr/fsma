//Fichero donde se inializa los paquetes que se van utilizar y la aplicacion
import { createApp, ref } from 'vue'
//Para los idiomas
import i18n from './components/i18n'
//la Aplicacion
import App from './App.vue'
//Para los estilos de la pagina 
import "bootstrap/scss/bootstrap.scss"
import * as bootstrap from 'bootstrap'
//Para el enrutado de la paginas 
import router from "./router";
//Crea la aplicacion
const app = createApp(App)
//los paquetes que utilizan
app.use(router)
app.use(i18n)
//Variables globales
app.provide('SearchVisible',true)
app.config.globalProperties.$SearchVisible = ref(false)
app.config.globalProperties.$SearchBarVisible = ref(false)
app.config.globalProperties.$user = ref(null)
//Montar la aplicaion
app.mount('#app')

router.beforeEach((to, from, next)=>{
    //Valida que si esta logeado el usuario no pueda acceder a register o login
    if((to.path=="/login" || to.path=="/register") && app.config.globalProperties.$user.value !== null){
        next({
            name:"Home",
        });
        return;
    }
    if((to.name =='Serie' ||to.name == 'Movie') && !/^\d+$/.test(to.params.id)){
        next({
            name:"Home",
        });
        return;
    }
    next();
})